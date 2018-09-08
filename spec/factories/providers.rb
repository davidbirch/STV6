# == Schema Information
#
# Table name: providers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  service_tier      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :provider do
    name "test provider"
  end
  
  factory :invalid_provider, parent: :provider do |f|
    f.name ""
  end
    
  factory :freeview_provider, parent: :provider do |f|
    f.name "Freeview"
  end
  
  factory :another_provider, parent: :provider do |f|
    f.name "Anther Provider"
  end
  
end
