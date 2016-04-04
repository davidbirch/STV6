# == Schema Information
#
# Table name: regions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Region < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :programs
  has_many :sports, through: :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  before_save :set_url_friendly_name
  
    protected
      def set_url_friendly_name
       self.url_friendly_name = name.parameterize
      end 
    
end
