# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  xmltv_id                :string(255)
#  free_or_pay             :string(255)
#  name                    :string(255)
#  short_name              :string(255)
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  url_friendly_name       :string(255)
#  url_friendly_short_name :string(255)
#

class Channel < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :programs
  
  validates_presence_of :name
  validates_presence_of :short_name
  validates_presence_of :xmltv_id
  
  validates_uniqueness_of :name
  validates_uniqueness_of :xmltv_id
  
  default_scope { order(:short_name) }
  
  before_save :set_computed_columns
  
  class << self
    
    def create_from_raw_channel(raw_channel)
      Channel.create(
        :name       => raw_channel.channel_name,
        :short_name => raw_channel.channel_name[0,4],
        :xmltv_id   => raw_channel.xmltv_id 
      )
    end
    
  end
  
    protected
  
    def set_computed_columns
        set_url_friendly_name
        set_url_friendly_short_name
    end
    
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 
    
    def set_url_friendly_short_name
      self.url_friendly_short_name = short_name.parameterize
    end

end
