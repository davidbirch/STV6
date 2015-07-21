# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  sport_id           :integer
#  priority           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  url_friendly_value :string(255)
#

class Keyword < ActiveRecord::Base
  
  belongs_to :sport
  
  extend FriendlyId
  friendly_id :url_friendly_value
  
  validates_presence_of :value, :sport_id, :priority
  
  validates_uniqueness_of :value
  
  before_save :set_url_friendly_value
  
  default_scope {select("*, LENGTH(value) as value_length")}
  
    protected
      def set_url_friendly_value
       self.url_friendly_value = value.parameterize
      end 
  
end
