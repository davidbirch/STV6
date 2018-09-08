# == Schema Information
#
# Table name: broadcast_services
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :broadcast_service do
    region_id 1
    channel_id 2
  end
  
  factory :invalid_broadcast_service, parent: :broadcast_service do |f|
    f.region_id nil
  end
  
  factory :broadcast_service_two, parent: :broadcast_service do |f|
    f.region_id 4
    f.channel_id 5
  end
    
end
