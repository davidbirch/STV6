class RawGuideData
  @log = Logger.new(File.expand_path("#{Rails.root}/log/raw_guide_data.log", __FILE__))
       
  def self.convert #converts the program and channel data
    begin
      @log.info("raw_guide_coonversion started...")
      convert_raw_channels
      convert_raw_programs
      create_conversion_summary
      write_conversion_summary_to_log
      @log.info("raw_guide_conversion completed.")
    rescue => e
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")          
    end
  end
  
  private
  
    def self.convert_raw_channels
      @raw_channel_count = RawChannel.count
      @starting_channel_count = Channel.count
      @channels_created = 0
      @channels_skipped = 0
      
      # temporarily limit to 100
      #RawChannel.limit(100).each do |raw_channel|
      
      RawChannel.find_each do |raw_channel|
        channel = Channel.create_from_raw_channel(raw_channel)
        if channel.new_record?
          @channels_skipped = @channels_skipped + 1
        else
          @channels_created = @channels_created + 1
        end
      end
      
      @final_channel_count = Channel.count
      #RawChannel.delete_all
      @final_raw_channel_count = RawChannel.count
    end
    
    def self.convert_raw_programs
      @starting_raw_program_count = RawProgram.count 
      @historic_raw_program_count = RawProgram.historic.count
      #RawProgram.historic.delete_all
      
      @historic_program_count = 0
      @starting_program_count = Program.count      
      @remaining_raw_program_count = RawProgram.count
      @remaining_program_count = Program.count
      @programs_created = 0
      @programs_skipped = 0
      
      # temporarily limit to 100
      #RawProgram.limit(100).each do |raw_program|  
      
      RawProgram.find_each do |raw_program|
        program = Program.create_from_raw_program(raw_program)
        if program.new_record?
          @programs_skipped = @programs_skipped + 1
        else
          @programs_created = @programs_created + 1
        end
      end
      
      @final_program_count = Program.count
      #RawProgram.delete_all
      @final_raw_program_count = RawProgram.count
    end
    
    def self.create_conversion_summary
      ConversionSummary.create(
        :raw_channel_count       => @raw_channel_count,
        :final_raw_channel_count => @final_raw_channel_count,
        :starting_channel_count  => @starting_channel_count,
        :channels_created => @channels_created,
        :channels_skipped => @channels_skipped,
        :final_channel_count => @final_channel_count,
        :raw_program_count => @raw_program_count,
        :final_raw_program_count => @final_raw_program_count,
        :starting_program_count  => @starting_program_count,
        :programs_created => @programs_created,
        :programs_skipped => @programs_skipped,
        :final_program_count => @final_program_count,
        :conversion_completed => true
      )   
    end
    
    def self.write_conversion_summary_to_log
      @log.info("+-------------+-----------+-----------+-----------+-----------+-----------+-----------+")
      @log.info("|             | Starting  | Historic  | Remaining |  Created  |  Skipped  | Remaining |")
      @log.info("+-------------+-----------+-----------+-----------+-----------+-----------+-----------+")
      @log.info("|Raw Channels |    #{@raw_channel_count.to_s.rjust(6)} |       N/A |       N/A |       N/A |       N/A |    #{@final_raw_channel_count.to_s.rjust(6)} |")
      @log.info("|Channels     |    #{@starting_channel_count.to_s.rjust(6)} |       N/A |    #{@starting_channel_count.to_s.rjust(6)} |    #{@channels_created.to_s.rjust(6)} |    #{@channels_skipped.to_s.rjust(6)} |    #{@final_channel_count.to_s.rjust(6)} |")
      @log.info("|Raw Programs |    #{@starting_raw_program_count.to_s.rjust(6)} |    #{@historic_raw_program_count.to_s.rjust(6)} |    #{@remaining_raw_program_count.to_s.rjust(6)} |       N/A |       N/A |    #{@final_raw_program_count.to_s.rjust(6)} |")
      @log.info("|Programs     |    #{@starting_program_count.to_s.rjust(6)} |    #{@historic_program_count.to_s.rjust(6)} |    #{@remaining_program_count.to_s.rjust(6)} |    #{@programs_created.to_s.rjust(6)} |    #{@programs_skipped.to_s.rjust(6)} |    #{@final_program_count.to_s.rjust(6)} |")
      @log.info("+-------------+-----------+-----------+-----------+-----------+-----------+-----------+")  
    end
    
  
end
