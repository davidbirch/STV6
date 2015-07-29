class Scraper
  require 'open-uri'
  @log = Logger.new(File.expand_path("#{Rails.root}/log/scraper.log", __FILE__))
  REGION_LIST = [["Adelaide","81"],["Brisbane","75"],["Melbourne","94"],["Perth","101"],["Sydney","73"]]
  DAYS_TO_GATHER = 0.125 # days
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
            
            # access the file and the data_hash
            file = URI.parse(encoded_uri)
            data_hash = JSON.parse(file.read)
               
            # populate a sorted array of times from the tv shows
            data_hash["tv"][0]["item"].each {|tv|
              puts tv.inspect
              
            }                 
          end
      }
        
      @log.info("=== Scraper completed.")
    rescue => e
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")
    end
  end
  
end
