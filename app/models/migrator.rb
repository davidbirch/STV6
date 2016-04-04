# == Schema Information
#
# Table name: migrators
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Migrator < ActiveRecord::Base
  
  validates_presence_of :target_region_list
  validates_presence_of :requested_by
 
  before_validation :set_default_params 
  after_create :run_migrator_job
  
  scope :by_requested_at, ->{order("requested_at DESC")}
 
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list = ["Adelaide","Brisbane","Melbourne","Perth","Sydney"]
      end
      self.requested_at ||= Time.now
    end
    
    def run_migrator_job
      job = RunMigratorJob.perform_later(self)
    end
    
end
