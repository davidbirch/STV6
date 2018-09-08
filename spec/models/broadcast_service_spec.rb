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

require 'rails_helper'

RSpec.describe BroadcastService, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:broadcast_service)).to be_valid
  end
  
  it "is invalid without a region" do
    expect(FactoryGirl.build(:broadcast_service, region_id: nil)).to validate_presence_of(:region_id)
  end
  
  it "is invalid without a channel" do
    expect(FactoryGirl.build(:broadcast_service, channel_id: nil)).to validate_presence_of(:channel_id)
  end
  
  it "is invalid without a unique channel/region" do
    expect(FactoryGirl.build(:broadcast_service)).to validate_uniqueness_of(:channel_id).scoped_to(:region_id)
  end

  it "should belong to a region" do
    expect(FactoryGirl.build(:broadcast_service)).to belong_to(:region)
  end  
  
  it "should belong to a channel" do
    expect(FactoryGirl.build(:broadcast_service)).to belong_to(:channel)
  end
  
  it "should have many broadcast_events" do
    expect(FactoryGirl.build(:broadcast_service)).to have_many(:broadcast_events)
  end
  
  describe "should create from a raw channel" do
  
    before :each do
      @region = FactoryGirl.create(:region_adelaide)
      @provider = FactoryGirl.create(:freeview_provider)
      @raw_channel = FactoryGirl.create(:raw_channel_including_hash)
      @channel = Channel.create_from_raw_channel(@raw_channel)
    end
  
    it "can be created from a raw channel" do
      expect(BroadcastService.create_from_raw_channel(@raw_channel).new_record?).to be false
    end
    
    it "has valid associated region and channel" do
      @broadcast_service = BroadcastService.create_from_raw_channel(@raw_channel)
      expect(@broadcast_service.region).to eq(@region)
      expect(@broadcast_service.channel).to eq(@channel)
    end 
    
  end
    
end
