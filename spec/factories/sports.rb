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

end
