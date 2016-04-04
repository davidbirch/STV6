# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  url_friendly_value :string(255)
#  sport_id           :integer
#  priority           :integer
#  black_flag         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :keyword do
    value "MyString"
    sport_id 1
    priority 10
  end
    
  factory :invalid_keyword, parent: :keyword do |f|
    f.value ""
  end
 
  factory :ashes_keyword, parent: :keyword do |f|
    f.value "The Ashes"
  end 
end
