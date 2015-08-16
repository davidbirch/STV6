# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  days_to_gather     :float(24)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Scraper < ActiveRecord::Base
  
  validates_presence_of :days_to_gather
  validates_presence_of :target_region_list
  validates_numericality_of :days_to_gather
  
  before_validation :set_default_params 
  after_create :run_scraper_job
    
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list = {"Adelaide":"81","Brisbane":"75","Melbourne":"94","Perth":"101","Sydney":"73"}.to_json
      end
      self.days_to_gather ||= 5
    end
    
    def run_scraper_job
      job = RunScraperJob.perform_later(self)
    end
    
end
