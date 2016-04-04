class RunMigratorJob < ActiveJob::Base
  queue_as :default
  
  def perform(migrator)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/migrator.log", __FILE__))
    begin
      if migrator.nil?
          @log.info("Migrator started")
          @log.error("Migrator was nil")
      else
        @log.info("Migrator started (id:#{migrator.id})")
        migrator.log ||= ""
        migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Migrator started (id:#{migrator.id})")
        migrator.started_at = Time.now
        migrator.status = "Started"
        migrator.save
          
        begin
          region_list = JSON.parse(migrator.target_region_list)
          region_list.each {|region_name|
            region = Region.find_by_name(region_name)
            raw_programs =  RawProgram.where(region_name: region_name)
            #@log.info("Processing #{raw_programs.count} raw programs for #{region_name}.")
              
            migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Processing #{raw_programs.count} raw programs for #{region_name}.")
            migrator.save
            
            raw_program_count = 0
            programs_skipped = 0
            programs_created = 0
            raw_programs.each do |raw_program|
              raw_program_count += 1
              #@log.info("Processing Raw Program: #{raw_program.id}, Created: #{programs_created}, Skipped: #{programs_skipped}, Total: #{programs_skipped + programs_created}.")
              program = Program.create_from_raw_program(raw_program)
              if program.new_record?
                programs_skipped += 1
              else
                programs_created += 1
              end
              if (raw_program_count % 1000) == 0
                migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Created: #{programs_created}, Skipped: #{programs_skipped}, Total: #{programs_skipped + programs_created}.")
                migrator.save
              end
              
            end   
            migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Created: #{programs_created}, Skipped: #{programs_skipped}, Total: #{programs_skipped + programs_created}.")
            migrator.save
            raw_programs.delete_all  
          }
          
          # completed
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Migrator completed (id:#{migrator.id})")
          migrator.completed_at = Time.now
          migrator.status = "Completed"
          migrator.save
          @log.info("Migrator completed (id:#{migrator.id})")
          
        rescue JSON::ParserError => e
          # specific error for parsing the json on target_region_list
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: JSON Parse Error")
          migrator.status = "Error"
          migrator.save
          
        rescue => e
          # generic error once the migrator exists
          @log.error("#{e.message}")
          @log.error("#{e.backtrace}")
          
          migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
          migrator.status = "Error"
          migrator.save
        end
      end     
    rescue => e
      # generic error if the migrator doesn't exist
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")
      
      migrator.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
      migrator.status = "Error"
      migrator.save
    end
  end
  
end