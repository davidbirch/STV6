class RunMigratorJob < ActiveJob::Base
  queue_as :default
  
  def perform(migrator)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/migrator.log", __FILE__))
    begin
      @log.info("Migrator started")
      if migrator.nil?
          @log.error("Migrator was nil")
      else
        migrator.log ||= ""
        migrator.log.concat("#{Time.now.strftime("%F %T %Z")}: Migrator started (id:#{migrator.id})")
        migrator.status = "Started"
        migrator.save
          
        begin
          region_list = JSON.parse(migrator.target_region_list)
          region_list.each {|region_name|
            region = Region.find_by_name(region_name)
            raw_programs =  RawProgram.where(region_name: region_name)
            migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Processing #{raw_programs.count} raw programs for #{region_name}.")
            migrator.save
            
            programs_skipped = 0
            programs_created = 0
            raw_programs.each do |raw_program|
              program = Program.create_from_raw_program(raw_program)
              if program.new_record?
                programs_skipped += 1
              else
                programs_created += 1
              end
            end   
            migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Created: #{programs_created}, Skipped: #{programs_skipped}, Total: #{programs_skipped + programs_created}.")
            migrator.save
            raw_programs.delete_all  
          }
          
          # completed
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Migrator completed")
          migrator.status = "Completed"
          migrator.save
          @log.info("Migrator completed")
          
        rescue JSON::ParserError => e
          # specific error for parsing the json on target_region_list
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: JSON Parse Error")
          migrator.status = "Error"
          migrator.save
          
        rescue => e
          # generic error once the scraper exists
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
          migrator.status = "Error"
          migrator.save
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