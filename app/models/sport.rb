# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sport < ActiveRecord::Base
  
  has_many :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }
  
end
