class RunJob < ActiveJob::Base
  queue_as :default
  
  require 'open-uri'
  
  def perform(job)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/job.log", __FILE__))
    begin
      if job.nil?
          @log.error("Job was nil")
      else        
        @log.info("Job started (id:#{job.id})")
        job.log = ""
        job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Job started (id:#{job.id})")
        job.started_at = Time.now
        job.status = "Started"
        job.save          
        begin
          # inspect the detail
          detail = job.detail
          if detail.nil?
            job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Detail is nil")
            job.status = "Error"
            job.save          
          else
            # run the detailed job
            result = detail.run_job(job)
            if result
              # completed and true
              job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Job completed")
              job.completed_at = Time.now
              job.status = "Completed"
              job.save
              @log.info("Job completed (id:#{job.id})")
            else
              # completed and true
              job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Job failed")
              job.completed_at = Time.now
              job.status = "Failed"
              job.save
              @log.info("Job failed")
            end
          end
        
        rescue => e
          # generic error once the scraper exists
          @log.error("#{e.message}")
          @log.error("#{e.backtrace}")
          
          job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
          job.status = "Error"
          job.save
        end
      end     
    rescue => e
      # generic error if the scraper doesn't exist
      @log.error("#{e.message}")
      @log.error("#{e.backtrace}")
      
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: Error (#{e.message})")
      job.status = "Error"
      job.save
    end
  end
  
end