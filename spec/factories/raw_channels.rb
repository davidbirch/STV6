# == Schema Information
#
# Table name: raw_channels
#
#  id            :integer          not null, primary key
#  channel_hash  :text(65535)
#  channel_name  :string(255)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :raw_channel do
    channel_name "ABC Hobart"
    channel_tag "AHB"
    region_name "Hobart"
    region_lookup 12345
    channel_hash  "{\"id\"=>148, \"channelCategoryId\"=>12, \"channelTag\"=>\"NIA\", \"channelImages\"=>{\"hq\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_425x243.png\", \"small\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_65x30.png\", \"medium\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_290x170.png\"}, \"name\"=>\"Channel 9 Adelaide\", \"number\"=>100}"
  end
  
  factory :invalid_raw_channel, parent: :raw_channel do |f|
    f.channel_tag ""
  end
  
  factory :raw_channel_including_hash, parent: :raw_channel do |f|
    f.channel_name "Channel 9 Adelaide"
    f.channel_tag "NIA"
    f.region_name "Adelaide"
    f.region_lookup 20480
    f.channel_hash  "{\"id\"=>148, \"channelCategoryId\"=>12, \"channelTag\"=>\"NIA\", \"channelImages\"=>{\"hq\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_425x243.png\", \"small\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_65x30.png\", \"medium\"=>\"https://www.foxtel.com.au/content/dam/foxtel/shared/channel/FTA/NIA_290x170.png\"}, \"name\"=>\"Channel 9 Adelaide\", \"number\"=>100}"
  end

end
