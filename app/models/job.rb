# == Schema Information
#
# Table name: jobs
#
#  id           :bigint(8)        not null, primary key
#  log          :text(65535)
#  status       :string(255)
#  requested_by :string(255)
#  requested_at :datetime
#  started_at   :datetime
#  completed_at :datetime
#  detail_id    :integer
#  detail_type  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Job < ActiveRecord::Base
  
  belongs_to :detail, :polymorphic => true
  
  validates_presence_of :detail_id
  validates_presence_of :detail_type
  validates_presence_of :requested_by
 
  before_validation :set_default_params 
  after_create :run_job
  
  scope :by_created_at, ->{order("created_at DESC")}
  
  class << self
    
    def find_or_create_from_detail(detail)
      job = detail.job
      if job.nil?
        job = Job.create(
          :requested_by => detail.requested_by,
          :requested_at => Time.now,
          :detail       => detail
        )        
      end
      job
    end
  
  end
  
  private
  
    def set_default_params
      self.requested_at ||= Time.now
    end
    
    def run_job
      job = RunJob.perform_later(self)
    end
    
end
