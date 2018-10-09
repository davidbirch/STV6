# == Schema Information
#
# Table name: regions
#
#  id                :bigint(8)        not null, primary key
#  name              :string(255)
#  time_zone_name    :string(255)
#  url_friendly_name :string(255)
#  region_lookup     :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryBot.define do
  factory :region do 
    name { "Melbourne" }
    time_zone_name { "Australia/Melbourne" }
    region_lookup { 12345 }
  end
  
  factory :invalid_region, parent: :region do |f|
    f.name { "" }
  end
  
  factory :region_brisbane, parent: :region do |f|
    f.name { "Brisbane" }
    f.time_zone_name { "Australia/Brisbane" }
  end
 
  factory :region_melbourne, parent: :region do |f|
    f.name { "Melbourne" }
    f.time_zone_name { "Australia/Melbourne" }
  end

  factory :region_hobart, parent: :region do |f|
    f.name { "Hobart" }
    f.time_zone_name { "Australia/Hobart" }
  end
  
  factory :region_adelaide, parent: :region do |f|
    f.name { "Adelaide" }
    f.time_zone_name { "Australia/Adelaide" }
  end
  
  factory :region_with_black_flag, parent: :region do |f|
    f.name { "Ballarat" }
    f.black_flag { true }
  end 

end
