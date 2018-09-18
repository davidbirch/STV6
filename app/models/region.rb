# == Schema Information
#
# Table name: regions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  time_zone_name    :string(255)
#  url_friendly_name :string(255)
#  region_lookup     :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Region < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :broadcast_services, dependent: :destroy
  has_many :channels, through: :broadcast_services
  has_many :broadcast_events, through: :broadcast_services
  
  validates_presence_of :name
  validates_presence_of :time_zone_name
  validates_presence_of :region_lookup
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }
  scope :whitelisted, ->{where(black_flag: false)}
    
  before_save :set_url_friendly_name
  
  def earliest_broadcast_event_date
    self.broadcast_events.chronological.first.formatted_scheduled_date.in_time_zone(self.time_zone_name).strftime("%F")
  end

  def latest_broadcast_event_date
    self.broadcast_events.chronological.last.formatted_scheduled_date.in_time_zone(self.time_zone_name).strftime("%F")
  end

  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 
    
end
