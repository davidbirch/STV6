# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
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
  
  validates_uniqueness_of :name
  
  default_scope { order(:short_name) }
  
  before_save :set_computed_columns
  
  class << self
    
    def find_or_create_from_raw_program(raw_program)
      Channel.find_or_create_by(name: raw_program.channel_name) do |c|
        c.short_name = raw_program.channel_name[0,4]
      end
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
