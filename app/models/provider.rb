# == Schema Information
#
# Table name: providers
#
#  id                :bigint(8)        not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  service_tier      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Provider < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :channels, dependent: :destroy
  has_many :broadcast_services, through: :channels
    
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }

  before_save :set_url_friendly_name
    
  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
