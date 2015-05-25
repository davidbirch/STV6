# == Schema Information
#
# Table name: regions
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  timezone_adjustment :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :region do 
    name "Test Region"
    timezone_adjustment 0
  end
  
  factory :invalid_region, parent: :region do |f|
    f.name ""
    f.timezone_adjustment 0
  end
  
  factory :region_brisbane, parent: :region do |f|
    f.name "Brisbane"
    f.timezone_adjustment 0
  end
 
  factory :region_melbourne, parent: :region do |f|
    f.name "Melbourne"
    f.timezone_adjustment 0
  end 

  factory :region_perth_with_adjustment, parent: :region do |f|
    f.name "Perth"
    f.timezone_adjustment -180
  end 

end
