# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  days_to_gather     :float(24)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Scraper < ActiveRecord::Base
  
  validates_presence_of :days_to_gather
  validates_presence_of :target_region_list
  validates_presence_of :requested_by
  validates_numericality_of :days_to_gather
  
  before_validation :set_default_params 
  after_create :run_scraper_job
  
  scope :by_requested_at, ->{order("requested_at DESC")}
     
  private
  
    def set_default_params
      if self.target_region_list.nil? || self.target_region_list == ""
        self.target_region_list = [["Adelaide","81"],["Brisbane","75"],["Melbourne","94"],["Perth","101"],["Sydney","73"]]
      end
      self.days_to_gather ||= 6
      self.requested_at ||= Time.now
    end
    
    def run_scraper_job
      job = RunScraperJob.perform_later(self)
    end
    
end
