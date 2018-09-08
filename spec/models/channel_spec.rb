# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  channel_hash            :text(65535)
#  name                    :string(255)
#  url_friendly_name       :string(255)
#  short_name              :string(255)
#  tag                     :string(255)
#  url_friendly_short_name :string(255)
#  default_sport           :string(255)
#  provider_id             :integer
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe Channel, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:channel)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryGirl.build(:channel, name: nil)).to validate_presence_of(:name)
  end
  
  it "is invalid without a short name" do
    expect(FactoryGirl.build(:channel, short_name: nil)).to validate_presence_of(:short_name)
  end
  
  it "is invalid without a tag" do
    expect(FactoryGirl.build(:channel, tag: nil)).to validate_presence_of(:tag)
  end
  
  it "is invalid without a provider" do
    expect(FactoryGirl.build(:channel, provider_id: nil)).to validate_presence_of(:provider_id)
  end
  
  it "is invalid without a unique tag" do
    expect(FactoryGirl.build(:channel)).to validate_uniqueness_of(:tag)
  end
  
  it "sets a url friendly name" do
    @channel = FactoryGirl.create(:channel)
    expect(@channel.url_friendly_name).to eq((@channel.name+" "+@channel.tag).parameterize)
  end

  it "sets a url friendly short name" do
    @channel = FactoryGirl.create(:channel)
    expect(@channel.url_friendly_short_name).to eq(@channel.short_name.parameterize)
  end
  
  it "should belong to a provider" do
    expect(FactoryGirl.build(:channel)).to belong_to(:provider)
  end
  
  it "should have many broadcast services" do
    expect(FactoryGirl.build(:channel)).to have_many(:broadcast_services)
  end
  
  it "should have many channels through broadcast services" do
    expect(FactoryGirl.build(:channel)).to have_many(:regions).through(:broadcast_services)
  end

  it "should have many broadcast_events through broadcast services" do
    expect(FactoryGirl.build(:channel)).to have_many(:broadcast_events).through(:broadcast_services)
  end
  
  it "can be found by the friendly id" do
    @channel = FactoryGirl.create(:channel)
    expect(Channel.find(@channel.id)).to eq(@channel)
    expect(Channel.friendly.find(@channel.id)).to eq(@channel)
    expect(Channel.friendly.find(@channel.url_friendly_name)).to eq(@channel)
  end
  
  it "can be created from a raw channel" do
    @provider = FactoryGirl.create(:freeview_provider)
    @raw_channel = FactoryGirl.create(:raw_channel_including_hash)
    expect(Channel.create_from_raw_channel(@raw_channel).new_record?).to be false
  end


end
