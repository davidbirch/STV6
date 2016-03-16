# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  url_friendly_name :string(255)
#

class Category < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  before_save :set_url_friendly_name
  
  class << self
    
    def find_or_create_from_raw_program(raw_program)
      if raw_program.category == ""
        Category.find_or_create_by(name: "(no category)") do |c|
          c.black_flag = false
        end
      else
        Category.find_or_create_by(name: raw_program.category) do |c|
          c.black_flag = false
        end
      end
      

    end
    
  end
  
  protected
    
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
