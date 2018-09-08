# == Schema Information
#
# Table name: sports
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :sport do
    name "test sport"
  end
  
  factory :invalid_sport, parent: :sport do |f|
    f.name ""
  end
    
  factory :cricket_sport, parent: :sport do |f|
    f.name "Cricket"
  end
  
  factory :other_sport, parent: :sport do |f|
    f.name "Other Sport"
  end
  
  factory :tennis_sport, parent: :sport do |f|
    f.name "Tennis"
  end
  
  factory :sport_with_black_flag, parent: :sport do |f|
    f.name "Other Sport"
    f.black_flag true
  end

end
