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

class Cleaner < ActiveRecord::Base
  
  has_one :job, :as => :detail
  
  validates_presence_of :requested_by
  
  after_create :create_new_job
  
  scope :by_created_at, ->{order("created_at DESC")}
  
  # called from jobs as detail.run_job
  def run_job(job)
    @log = Logger.new(File.expand_path("#{Rails.root}/log/cleaner_job.log", __FILE__))
    @log.info("#{self.class} started (id:#{self.id})") 
  
    # clean raw_programs
    if self.clean_raw_programs
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{RawProgram.count} raw programs.")
      job.save    
      RawProgram.delete_all
    end
    
    # clean raw_channels
    if self.clean_raw_channels
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{RawChannel.count} raw channels.")
      job.save    
      RawChannel.delete_all
    end
    
    # clean all broadcast_events
    if self.clean_broadcast_events
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{BroadcastEvent.count} broadcast events.")
      job.save    
      BroadcastEvent.delete_all
    end
    
    # clean historic broadcast_events
    if self.clean_broadcast_events
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{BroadcastEvent.historic.count} historic broadcast events.")
      job.save    
      BroadcastEvent.historic.delete_all
    end
    
    # clean programs
    if self.clean_programs
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{Program.count} programs.")
      job.save    
      Program.delete_all
    end
    
    # clean broadcast_services
    if self.clean_broadcast_services
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{BroadcastService.count} broadcast services.")
      job.save    
      BroadcastService.delete_all
    end  
        
    # clean channels
    if self.clean_channels
      job.log.concat("\n#{Time.now.strftime("%F %T %Z")}: > Deleting #{Channel.count} channels.")
      job.save    
      Channel.delete_all
    end
     
    # entire job is completed
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
