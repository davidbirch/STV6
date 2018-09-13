# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  days_to_gather     :float(24)
#  requested_by       :string(255)
#  job_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Scraper < ActiveRecord::Base
  
  has_one :job, :as => :detail
  
  validates_presence_of :days_to_gather
  validates_presence_of :target_region_list
  validates_presence_of :requested_by
  validates_numericality_of :days_to_gather
  
  before_validation :set_default_params
  
  after_create :create_new_job
  
  scope :by_created_at, ->{order("created_at DESC")}
  
  # called from jobs as detail.run_job
  def run_job(job)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/scraper_job.log", __FILE__))
    @log.info("Job started")
         
    # initial job parameters
    region_list = JSON.parse(self.target_region_list)
    days_to_gather = self.days_to_gather
    size_of_a_day = 86400 # epoch time units (86400 is equal to 24 hours)
    size_of_a_time_slice = 10800 # epoch time units (10800 is equal to 3 hours)
    
    # start gathering from the beginning of the current day
    initial_start_time = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
    number_of_time_slices = ((days_to_gather * size_of_a_day) / size_of_a_time_slice).to_i
    
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > #{self.class} started (id:#{self.id})")
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The Epoch Start Time: #{initial_start_time}")
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The Formatted Start Time: #{Time.at(initial_start_time).strftime("%c")}")
    job.save
    
    # iterate each region
    region_list.each {|region_name,region_lookup|  
      #validate a region exists
      region =  Region.find_by name: region_name
      if region
        
        # run the channel scraper
        encoded_uri = URI.encode("https://www.foxtel.com.au/webepg/ws/foxtel/channels?regionId=" + region_lookup)
        #job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The encoded URI for #{region_name} is #{encoded_uri}")
        #job.save
        raw_channels_created = 0
        raw_channels_skipped = 0

        # access the file and the data_hash
        file = URI.parse(encoded_uri)
        get_file_count = 0
        begin
          data_hash = JSON.parse(file.read)
        rescue Errno::ECONNRESET => e
          get_file_count += 1
          retry unless get_file_count > 10
          job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Tried #{get_file_count} times and couldn't get #{file}: #{e}")
          job.save
          @log.error("#{e.message}")
          @log.error("#{e.backtrace}")
        rescue OpenSSL::SSL::SSLError => e
          get_file_count += 1
          retry unless get_file_count > 10
          job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Tried #{get_file_count} times and couldn't get #{file}: #{e}")
          job.save
          @log.error("#{e.message}")
          @log.error("#{e.backtrace}")
        end

        # populate an array of times from the data hash
        #@log.debug("#{data_hash.inspect}") 
        data_hash["channels"].each {|channel_hash|
              #@log.debug("#{channel_hash.inspect}")
              raw_channel = RawChannel.create_from_channel_hash(region, channel_hash)
              if raw_channel.new_record?
                raw_channels_skipped += 1
              else
                raw_channels_created += 1
              end
              }
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Raw Channels Created: #{raw_channels_created}, Skipped: #{raw_channels_skipped}, Total: #{raw_channels_skipped + raw_channels_created} for #{region_name}(#{region_lookup.to_s}).")
        job.save
        
        # run the program scraper
        raw_programs_created = 0
        raw_programs_skipped = 0
        
        number_of_time_slices.times do |i|
          start_time = Time.at(initial_start_time + (i* size_of_a_time_slice))
          end_time = Time.at(start_time.to_i + size_of_a_time_slice)
          encoded_uri = URI.encode("https://www.foxtel.com.au/webepg/ws/foxtel/grid/events?startDate=" + start_time.to_i.to_s + "000&endDate=" + end_time.to_i.to_s + "000&regionId=" + region_lookup)
          #job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The encoded URI is #{encoded_uri}")
          #job.save
                    
          # access the file and the data_hash
          file = URI.parse(encoded_uri)
          get_file_count = 0
          begin
            data_hash = JSON.parse(file.read)
          rescue Errno::ECONNRESET => e
            get_file_count += 1
            retry unless get_file_count > 10
            job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Tried #{get_file_count} times and couldn't get #{file}: #{e}")
            job.save
            @log.error("#{e.message}")
            @log.error("#{e.backtrace}")
          rescue OpenSSL::SSL::SSLError => e
            get_file_count += 1
            retry unless get_file_count > 10
            job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Tried #{get_file_count} times and couldn't get #{file}: #{e}")
            job.save
            @log.error("#{e.message}")
            @log.error("#{e.backtrace}")
          end
          
          # populate an array of times from the data hash
          #@log.debug("#{data_hash.inspect}")
          data_hash["channelEventsByTag"].each {|channel_events|
            #@log.debug("#{program_array.inspect}")
            channel_tag = channel_events[0]
            channel = Channel.find_by_tag(channel_tag)
            raw_channel = RawChannel.find_by_channel_tag_and_region_name(channel_tag,region_name)
            if channel.nil? and raw_channel.nil?
              # no channel or raw channel
              job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The channel record and raw_channel record for #{channel_tag} in #{region_name} does not exist!")
              job.save
            else
              # channel is ok
              array_of_channel_events = channel_events[1]
              #job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Processing #{array_of_channel_events.length} channel events for channel #{channel.name} for #{region_name}.")
              #job.save   
              array_of_channel_events.each { |channel_event|
                raw_program = RawProgram.create_from_channel_event(region, channel_tag, channel_event)
                if raw_program.new_record?
                  raw_programs_skipped += 1
                else
                  raw_programs_created += 1
                end  
              }                
            end
          }
        end
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Raw Programs Created #{raw_programs_created}, Skipped: #{raw_programs_skipped}, Total: #{raw_programs_created + raw_programs_skipped} for #{region_name}(#{region_lookup.to_s}).")
        job.save
      else
        # no region
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The region record for #{region_name} does not exist!")
        job.save
      end
    }
    
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > #{self.class} completed (id:#{self.id})")
    job.save
    
    @log.info("#{self.class} completed (id:#{self.id})")
    return true
  end
    
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list =  Region.pluck(:name, :region_lookup)
      end
      self.days_to_gather ||= 4
    end
    
    def create_new_job
      job = Job.find_or_create_from_detail(self)
      self.update(job_id: job.id)
    end
        
end
