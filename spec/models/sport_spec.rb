# == Schema Information
#
# Table name: sports
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  url_friendly_name :string(255)
#

require 'rails_helper'

RSpec.describe Sport, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:sport)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryGirl.build(:sport, name: nil)).to validate_presence_of(:name)
  end
 
  it "is invalid without a unique name" do
    expect(FactoryGirl.build(:sport)).to validate_uniqueness_of(:name)
  end
  
  it "sets a url friendly name" do
    @sport = FactoryGirl.create(:sport)
    expect(@sport.url_friendly_name).to eq(@sport.name.parameterize)
  end
    
  it "should have many programs" do
    expect(FactoryGirl.build(:sport)).to have_many(:programs)
  end
  
  it "can be found by the friendly id" do
    @sport = FactoryGirl.create(:sport)
    expect(Sport.find(@sport.id)).to eq(@sport)
    expect(Sport.friendly.find(@sport.id)).to eq(@sport)
    expect(Sport.friendly.find(@sport.url_friendly_name)).to eq(@sport)
  end
  
  describe "sort in alphabetical order by default" do
  
    context "where the sports are created in the correct sequence" do
      it "should be in alphabetical order by default" do
          @cricket_sport = FactoryGirl.create(:cricket_sport)
          @tennis_sport = FactoryGirl.create(:tennis_sport)
          sports = Sport.all
          expect(sports.count).to eq(2)
          expect(sports.first).to eq(@cricket_sport)
      end
    end
    
    context "where the sports are created in the incorrect sequence" do
      it "should be in alphabetical order by default" do
          @tennis_sport = FactoryGirl.create(:tennis_sport)
          @cricket_sport = FactoryGirl.create(:cricket_sport)
          sports = Sport.all
          expect(sports.count).to eq(2)
          expect(sports.first).to eq(@cricket_sport)
      end
    end
  end
  
end
