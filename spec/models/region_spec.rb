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

require 'rails_helper'

RSpec.describe Region, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.create(:region)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryBot.build(:region, name: nil)).to_not be_valid
  end

  it "is invalid without a time zone name" do
    expect(FactoryBot.build(:region, time_zone_name: nil)).to_not be_valid
  end
  
  it "is invalid without a region lookup" do
    expect(FactoryBot.build(:region, region_lookup: nil)).to_not be_valid
  end
  
  it "is invalid without a unique name" do
    expect(FactoryBot.build(:region)).to validate_uniqueness_of(:name)
  end
  
  it "should have many broadcast services" do
    expect(FactoryBot.build(:region)).to have_many(:broadcast_services)
  end
  
  it "should have many channels through broadcast services" do
    expect(FactoryBot.build(:region)).to have_many(:channels).through(:broadcast_services)
  end
  
  it "should have many broadcast_events through broadcast services" do
    expect(FactoryBot.build(:region)).to have_many(:broadcast_events).through(:broadcast_services)
  end
  
  it "sets a url friendly name" do
    @region = FactoryBot.create(:region)
    expect(@region.url_friendly_name).to eq(@region.name.parameterize)
  end

  it "can be found by the friendly id" do
    @region = FactoryBot.create(:region)
    expect(Region.find(@region.id)).to eq(@region)
    expect(Region.friendly.find(@region.id)).to eq(@region)
    expect(Region.friendly.find(@region.url_friendly_name)).to eq(@region)
  end
  
  describe "sort in alphabetical order by default" do
  
    context "where the regions are created in the correct sequence" do
      it "should be in alphabetical order by default" do
          @region_brisbane = FactoryBot.create(:region_brisbane)
          @region_melbourne = FactoryBot.create(:region_melbourne)
          regions = Region.all
          expect(regions.count).to eq(2)
          expect(regions.first).to eq(@region_brisbane)
      end
    end
    
    context "where the regions are created in the incorrect sequence" do
      it "should be in alphabetical order by default" do
          @region_melbourne = FactoryBot.create(:region_melbourne)
          @region_brisbane = FactoryBot.create(:region_brisbane)
          regions = Region.all
          expect(regions.count).to eq(2)
          expect(regions.first).to eq(@region_brisbane)
      end
    end
  end
    
end
