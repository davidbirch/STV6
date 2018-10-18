# == Schema Information
#
# Table name: cleaners
#
#  id                              :bigint(8)        not null, primary key
#  requested_by                    :string(255)
#  clean_raw_programs              :boolean
#  clean_raw_channels              :boolean
#  clean_broadcast_events          :boolean
#  clean_historic_broadcast_events :boolean
#  clean_programs                  :boolean
#  clean_broadcast_services        :boolean
#  clean_channels                  :boolean
#  job_id                          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
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
  
    # re-link all programs to keywords
    programs = Program.all
    job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Relinking #{programs.count} programs to keywords.")
    job.save  

    programs_skipped = 0
    programs_modified = 0
    programs.each do |program|
      current_keyword = program.keyword
      new_keyword = Keyword.find_based_on_title(program.title,program.episode_title)
      if new_keyword != current_keyword
        program.keyword = new_keyword
        program.save
        programs_modified += 1
      else
        programs_skipped += 1
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
