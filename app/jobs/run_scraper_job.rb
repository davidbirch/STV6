class RunScraperJob < ActiveJob::Base
  queue_as :default
  
  require 'open-uri'
  
  def perform(scraper)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/scraper.log", __FILE__))
    begin
      @log.info("Scraper started")
      if scraper.nil?
          @log.error("Scraper was nil")
      else
        scraper.log ||= ""
        scraper.log.concat("#{Time.now.strftime("%F %T %Z")}: Scraper started (id:#{scraper.id})")
        scraper.status = "Started"
        scraper.save
          
        begin
          region_list = JSON.parse(scraper.target_region_list)
          days_to_gather = scraper.days_to_gather
          size_of_a_day = 86400 # epoch time units (86400 is equal to 24 hours)
          size_of_a_time_slice = 10800 # epoch time units (10800 is equal to 3 hours)
            
          # start gathering from the beginning of the current day
          initial_start_time = Time.new(Time.now.year, Time.now.month, Time.now.day).to_i
          number_of_time_slices = ((days_to_gather * size_of_a_day) / size_of_a_time_slice).to_i
          scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: The Epoch Start Time: #{initial_start_time}")
          scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: The Formatted Start Time: #{Time.at(initial_start_time).strftime("%c")}")
      
          # iterate each region
          region_list.each {|region_name,region_code|  
            base_uri = ("https://au.tv.yahoo.com/tv-guide/data/" + region_code + "/168/")
            scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: The base URI is #{base_uri}")
            scraper.save
                
            number_of_time_slices.times do |i|
              start_time = Time.at(initial_start_time + (i* size_of_a_time_slice))
              end_time = Time.at(start_time.to_i + size_of_a_time_slice)
              encoded_uri = URI.encode(base_uri + start_time.to_i.to_s + "/" + end_time.to_i.to_s + "/")
              raw_program_count = 0
                        
              # access the file and the data_hash
              file = URI.parse(encoded_uri)
              get_file_count = 0
              begin
                data_hash = JSON.parse(file.read)
              rescue Errno::ECONNRESET => e
                get_file_count += 1
                retry unless get_file_count > 10
                scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Tried #{get_file_count} times and couldn't get #{file}: #{e}")
                scraper.save
              end
              # populate a sorted array of times from the tv shows
              data_hash["tv"][0]["item"].each {|tv|
                raw_program = RawProgram.create_raw_program_from_data_hash(region_name, tv)
                raw_program_count += 1
              }
              scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Created #{raw_program_count.to_s} raw programs for #{region_name}(#{region_code.to_s}) at #{start_time.strftime("%c")}.")
              scraper.save
            end
          }
          
          # completed
          scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Scraper completed")
          scraper.status = "Completed"
          scraper.save
          @log.info("Scraper completed")
          
        rescue JSON::ParserError => e
          # specific error for parsing the json on target_region_list
          scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: JSON Parse Error")
          scraper.status = "Error"
          scraper.save
          
        rescue => e
          # generic error once the scraper exists
          scraper.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
          scraper.status = "Error"
          scraper.save
          @log.error("#{e.message}")
          @log.error("#{e.backtrace}")
        end
      end     
    rescue => e
      # generic error if the scraper doesn't exist
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")
    end
  end
  
end