# == Schema Information
#
# Table name: linkers
#
#  id           :bigint(8)        not null, primary key
#  requested_by :string(255)
#  job_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Linker < ActiveRecord::Base
  
  has_one :job, :as => :detail
  
  validates_presence_of :requested_by
  
  after_create :create_new_job
  
  scope :by_created_at, ->{order("created_at DESC")}
  
  # called from jobs as detail.run_job
  def run_job(job)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/linker_job.log", __FILE__))
    @log.info("#{self.class} started (id:#{self.id})") 
  
    # *** to throttle for now
    #programs = Program.all
    programs = Program.where(sport_prediction: nil).limit(5000)
    # ***

    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Relinking #{programs.count} programs to keywords.")
    job.save  

    lambda = Aws::Lambda::Client.new(region: 'ap-southeast-2')

    programs_skipped = 0
    programs_modified = 0
    programs.each do |program|
      
      # for each program update the keyword
      current_keyword = program.keyword
      new_keyword = Keyword.find_based_on_title(program.title,program.episode_title)
      if new_keyword != current_keyword
        program.keyword = new_keyword
        program.save
        programs_modified += 1
      else
        programs_skipped += 1
      end

      # for each program make a prediction
      if (program.sport_prediction == nil or program.sport_prediction == "")
        program.sport_prediction_started_at = Time.now
        lambda_json_request = "{\"programTitle\": \"#{program.formatted_full_title}}\"}" # => {"programTitle : "[the program.formatted_full_title]"}
        response = lambda.invoke(function_name: 'mySportClassificationFunction', payload: lambda_json_request)
        lambda_json_response = JSON.load(response.payload.string) # => {"statusCode"=>200, "body"=>"[the program.formatted_full_title]", "isSport"=>true}
        program.sport_prediction_completed_at = Time.now
        if lambda_json_response["isSport"]
          program.sport_prediction = "Sport"
        else
          program.sport_prediction = "Non Sport"
        end
        program.save
      end
    end
        
    # entire job is completed
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Total programs modified:  #{programs_modified}")
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Total programs skipped:  #{programs_skipped}")          
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > #{self.class} completed (id:#{self.id})")
    job.save
    
    @log.info("#{self.class} completed (id:#{self.id})")
    return true
  end
  
  private
  
    def create_new_job
      job = Job.find_or_create_from_detail(self)
      self.update(job_id: job.id)
    end
      
end
