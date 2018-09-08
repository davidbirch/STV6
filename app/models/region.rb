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
  
  has_many :broadcast_services
  has_many :channels, through: :broadcast_services
  has_many :broadcast_events, through: :broadcast_services
  
  validates_presence_of :name
  validates_presence_of :time_zone_name
  validates_presence_of :region_lookup
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }
  
  before_save :set_url_friendly_name
  
  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 
    
end
