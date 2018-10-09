# == Schema Information
#
# Table name: sports
#
#  id                :bigint(8)        not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Sport < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :keywords, dependent: :destroy
  has_many :programs, through: :keywords
  has_many :broadcast_events, through: :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }
  scope :whitelisted, ->{where(black_flag: false)}
  
  before_save :set_url_friendly_name
    
  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
