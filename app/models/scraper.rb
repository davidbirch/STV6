class Scraper
  require 'open-uri'
  @log = Logger.new(File.expand_path("#{Rails.root}/log/scraper.log", __FILE__))
  REGION_LIST = [["Adelaide","81"],["Brisbane","75"],["Melbourne","94"],["Perth","101"],["Sydney","73"]]
  DAYS_TO_GATHER = 0.25 # days
  SIZE_OF_A_DAY = 86400 # epoch time units (86400 is equal to 24 hours)
  SIZE_OF_TIME_SLICE = 10800 # epoch time units (10800 is equal to 3 hours)
         
  def self.run # run the scraper
    begin
      @log.info("=== Scraper started...")
      @log.debug("The Region List: #{REGION_LIST.inspect}")
      @log.debug("Days To Gather: #{DAYS_TO_GATHER}")
      @log.debug("Size Of Time Slice: #{SIZE_OF_TIME_SLICE}")
      @log.debug("The Epoch Time: #{Time.now.to_i}")
      @log.debug("The Formatted Time: #{Time.now.strftime("%c")}")
      
      # start gathering from the beginning of the current day
      initial_start_time = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
      number_of_time_slices = ((DAYS_TO_GATHER * SIZE_OF_A_DAY) / SIZE_OF_TIME_SLICE).to_i
      @log.debug("The Epoch Start Time: #{initial_start_time}")
      @log.debug("The Formatted Start Time: #{Time.at(initial_start_time).strftime("%c")}")
           
      REGION_LIST.each {|region_name,region_code|
          base_uri = ("https://au.tv.yahoo.com/tv-guide/data/" + region_code + "/168/")
          
          number_of_time_slices.times do |i|
            start_time = Time.at(initial_start_time + (i* SIZE_OF_TIME_SLICE))
            end_time = Time.at(start_time.to_i + SIZE_OF_TIME_SLICE)
            encoded_uri = URI.encode(base_uri + start_time.to_i.to_s + "/" + end_time.to_i.to_s + "/")
            raw_program_count = 0
                      
            # access the file and the data_hash
            file = URI.parse(encoded_uri)
            data_hash = JSON.parse(file.read)
            
            # populate a sorted array of times from the tv shows
            data_hash["tv"][0]["item"].each {|tv|
              raw_program = create_raw_program_from_data_hash(region_name, tv)
              raw_program_count += 1
            }
            @log.info("Created #{raw_program_count.to_s} raw programs for #{region_name}(#{region_code.to_s}).")  
          end
      }
        
      @log.info("=== Scraper completed.")
    rescue => e
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")
    end
  end

  private
  
    def self.create_raw_program_from_data_hash(region_name, tv)
      attr_program_hash = tv
      attr_title = tv["title"][0]["0"] unless tv["title"].nil?
      attr_subtitle = tv["subtitle"][0]["0"] unless tv["subtitle"].nil?
      attr_category = tv["category"][0]["item"][0]["0"]
      attr_description = tv["description_1"]
      if tv["co_v_short"]
        if tv["co_v_short"].class == Array
          attr_channel_name = tv["co_v_short"][0]["0"]
          attr_channel_free_or_pay = "pay"
        else
          attr_channel_name = tv["co_v_short"]
          attr_channel_free_or_pay = "free"
        end   
      end
      attr_start_datetime = Time.at(tv["event_date"][0]["0"].to_i) unless tv["event_date"][0]["0"].nil?
      attr_end_datetime = Time.at(tv["event_date"][0]["0"].to_i) unless tv["event_date"][0]["0"].nil?
      
      # if nil then default to an empty string
      attr_title ||= ""
      attr_subtitle ||= ""
      attr_category ||= ""
      attr_description ||= ""
      
      RawProgram.create(
        :region_name          => region_name,
        :program_hash         => attr_program_hash,
        :title                => attr_title,
        :subtitle             => attr_subtitle,
        :category             => attr_category,
        :description          => attr_description,
        :channel_name         => attr_channel_name,
        :channel_free_or_pay  => attr_channel_free_or_pay,
        :start_datetime       => attr_start_datetime,
        :end_datetime         => attr_end_datetime,
        )
    end
  
end
