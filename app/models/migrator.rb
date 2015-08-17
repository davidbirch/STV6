# == Schema Information
#
# Table name: migrators
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Migrator < ActiveRecord::Base
  
  validates_presence_of :target_region_list
 
  before_validation :set_default_params 
  after_create :run_migrator_job
    
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list = ["Adelaide","Brisbane","Melbourne","Perth","Sydney"]
      end
    end
    
    def run_migrator_job
      job = RunMigratorJob.perform_later(self)
    end
    
end
