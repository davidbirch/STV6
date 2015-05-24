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

require 'rails_helper'

RSpec.describe RawChannel, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_channel)).to be_valid
  end

  it "has an invalid factory" do
    expect(FactoryGirl.build(:invalid_raw_channel)).to be_invalid
  end
    
  it "is invalid without an xmltv_id" do
    expect(FactoryGirl.build(:raw_channel, xmltv_id: nil)).to validate_presence_of(:xmltv_id)
  end
 
  it "is invalid without a channel name" do
    expect(FactoryGirl.build(:raw_channel, channel_name: nil)).to validate_presence_of(:channel_name)
  end
  
  it "is invalid without a unique channel name" do
    expect(FactoryGirl.build(:raw_channel)).to validate_uniqueness_of(:channel_name)
  end
  
  it "is invalid without a unique xmltv_id" do
    expect(FactoryGirl.build(:raw_channel)).to validate_uniqueness_of(:xmltv_id)
  end
  
end
