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

require 'rails_helper'

RSpec.describe RawChannel, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_channel)).to be_valid
  end

  it "has a valid factory including a channel hash" do
    expect(FactoryGirl.create(:raw_channel_including_hash)).to be_valid
  end

  it "is invalid without a region_name" do
    expect(FactoryGirl.build(:raw_channel, region_lookup: nil)).to validate_presence_of(:region_lookup)
  end

  it "is invalid without a region_name" do
    expect(FactoryGirl.build(:raw_channel, region_name: nil)).to validate_presence_of(:region_name)
  end
  
  it "is invalid without a channel name" do
    expect(FactoryGirl.build(:raw_channel, channel_name: nil)).to validate_presence_of(:channel_name)
  end
  
  it "is invalid without a channel tag" do
    expect(FactoryGirl.build(:raw_channel, channel_tag: nil)).to validate_presence_of(:channel_tag)
  end

end
