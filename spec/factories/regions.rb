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

FactoryGirl.define do
  factory :region do 
    name "Melbourne"
  end
  
  factory :invalid_region, parent: :region do |f|
    f.name ""
  end
  
  factory :region_brisbane, parent: :region do |f|
    f.name "Brisbane"
  end
 
  factory :region_melbourne, parent: :region do |f|
    f.name "Melbourne"
  end 

end
