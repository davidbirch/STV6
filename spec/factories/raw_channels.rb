# == Schema Information
#
# Table name: raw_channels
#
#  id           :integer          not null, primary key
#  xmltv_id     :string(255)
#  channel_name :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  
  factory :raw_channel do
    xmltv_id "test_channel.paytv.au"
    channel_name "Test channel"
  end
  
  factory :invalid_raw_channel, parent: :raw_channel do |f|
    f.channel_name ""
  end
  
  factory :raw_channel_seven, parent: :raw_channel do |f|
    f.xmltv_id "seven.free.au"
    f.channel_name "Seven"
  end
  
  factory :raw_channel_nine, parent: :raw_channel do |f|
    f.xmltv_id "nine.free.au"
    f.channel_name "Nine"
  end
    
end
