# == Schema Information
#
# Table name: migrators
#
#  id                 :bigint(8)        not null, primary key
#  target_region_list :text(65535)
#  requested_by       :string(255)
#  job_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Migrator < ActiveRecord::Base
  
  has_one :job, :as => :detail
  
  validates_presence_of :target_region_list
  validates_presence_of :requested_by
   
  before_validation :set_default_params
  
  after_create :create_new_job
  
  scope :by_created_at, ->{order("created_at DESC")}
    
  # called from jobs as detail.run_job
  def run_job(job)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/migrator_job.log", __FILE__))
    @log.info("#{self.class} started (id:#{self.id})")
    
    # initial job parameters
    region_list = JSON.parse(self.target_region_list)
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > #{self.class} started (id:#{self.id})")
    job.save
    
    region_list.each {|region_name|
      # validate the region record exists
      region = Region.find_by_name(region_name)
      if region
  
        # migrate the raw channels and broadcast services
        raw_channels =  RawChannel.where(region_name: region_name)
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Processing #{raw_channels.count} raw channels for #{region_name}.")
        job.save    
        raw_channel_count = 0
        channels_skipped = 0
        channels_created = 0
        broadcast_services_skipped = 0
        broadcast_services_created = 0
        raw_channels.each {|raw_channel|
          raw_channel_count += 1
          channel = Channel.create_from_raw_channel(raw_channel)
          if channel.new_record?
            channels_skipped += 1
          else
            channels_created += 1
          end
          broadcast_service = BroadcastService.create_from_raw_channel(raw_channel)
          if broadcast_service.new_record?
            broadcast_services_skipped += 1
          else
            broadcast_services_created += 1
          end
          if (raw_channel_count % 10000) == 0
            job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Channels Created: #{channels_created}, Skipped: #{channels_skipped}, Total: #{channels_skipped + channels_created}.")
            job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Broadcast Services Created: #{broadcast_services_created}, Skipped: #{broadcast_services_skipped}, Total: #{broadcast_services_skipped + broadcast_services_created}.")
            job.save
          end
        }
        # channel and broadcast service migration completed
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Channels Created: #{channels_created}, Skipped: #{channels_skipped}, Total: #{channels_skipped + channels_created}.")
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Broadcast Services Created: #{broadcast_services_created}, Skipped: #{broadcast_services_skipped}, Total: #{broadcast_services_skipped + broadcast_services_created}.")
        job.save
        raw_channels.delete_all
        
        # migrate the raw programs and broadcast events
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Processing #{RawProgram.where(region_name: region_name).count} raw programs for #{region_name}.")
        job.save    
       
        region.broadcast_services.each do |broadcast_service|
          raw_program_count = 0
          programs_skipped = 0
          programs_created = 0
          program_placeholders = 0
          broadcast_events_skipped = 0
          broadcast_events_created = 0
  
          RawProgram.where(region_name: broadcast_service.region.name, channel_tag: broadcast_service.channel.tag).each do |raw_program|
            raw_program_count += 1
            if raw_program.placeholder?
              program_placeholders += 1
            else
              program = Program.create_from_raw_program(raw_program, broadcast_service)
              if program.new_record?
                programs_skipped += 1
              else
                programs_created += 1
              end

              broadcast_event = BroadcastEvent.create_from_raw_program(raw_program, broadcast_service)
              if broadcast_event.new_record?
                broadcast_events_skipped += 1
              else
                broadcast_events_created += 1
              end

            end
            if (raw_program_count % 1000) == 0
              job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Counting #{raw_program_count} raw programs for #{broadcast_service.region.name} / #{broadcast_service.channel.tag}.")
              job.save    
            end
          end
     
          #if programs_created > 0
          #  job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Programs Created: #{programs_created}, Placeholders: #{program_placeholders}, Skipped: #{programs_skipped}, Total: #{programs_created + program_placeholders + programs_skipped}.")
          #  job.save
          #end
          #if broadcast_events_created > 0
          #  job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Broadcast Events Created: #{broadcast_events_created}, Skipped: #{broadcast_events_skipped}, Total: #{broadcast_events_created + broadcast_events_skipped}.")
          #  job.save
          #end
          #if raw_program_count > 0
          #  job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{raw_program_count} raw programs for #{broadcast_service.region.name} / #{broadcast_service.channel.tag}.")
          #  job.save    
          #end
          
          RawProgram.where(region_name: broadcast_service.region.name, channel_tag: broadcast_service.channel.tag).delete_all
        end
      else
        # no region
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > The region record for #{region_name} does not exist!")
        job.save
      end      
    }
      
    # entire job is completed
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > #{self.class} completed (id:#{self.id})")
    job.save
    
    @log.info("#{self.class} completed (id:#{self.id})")
    return true
  end
  
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list =  Region.pluck(:name)
      end
    end
    
    def create_new_job
      job = Job.find_or_create_from_detail(self)
      self.update(job_id: job.id)
    end
        
end
