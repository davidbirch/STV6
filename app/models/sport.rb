# == Schema Information
#
# Table name: sports
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  url_friendly_name :string(255)
#

class Sport < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :programs
  has_many :keywords
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }

  before_save :set_url_friendly_name
    
  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
