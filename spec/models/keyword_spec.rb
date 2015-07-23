# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  sport_id           :integer
#  priority           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  url_friendly_value :string(255)
#

require 'rails_helper'

RSpec.describe Keyword, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:keyword)).to be_valid
  end
  
  it "is invalid without a value" do
    expect(FactoryGirl.build(:keyword, value: nil)).to_not be_valid
  end

  it "is invalid without a sport_id" do
    expect(FactoryGirl.build(:keyword, sport_id: nil)).to_not be_valid
  end
  
  it "is invalid without a priority" do
    expect(FactoryGirl.build(:keyword, priority: nil)).to_not be_valid
  end
 
  it "is invalid without a unique value" do
    expect(FactoryGirl.build(:keyword)).to validate_uniqueness_of(:value)
  end
  
  it "should belong to a sport" do
    expect(FactoryGirl.build(:keyword)).to belong_to(:sport)
  end
  
  it "should have many programs" do
    expect(FactoryGirl.build(:keyword)).to have_many(:programs)
  end
  
  it "sets a url friendly value" do
    @keyword = FactoryGirl.create(:keyword)
    expect(@keyword.url_friendly_value).to eq(@keyword.value.parameterize)
  end
  
  it "can be found by the friendly id" do
    @keyword = FactoryGirl.create(:keyword)
    expect(Keyword.find(@keyword.id)).to eq(@keyword)
    expect(Keyword.friendly.find(@keyword.id)).to eq(@keyword)
    expect(Keyword.friendly.find(@keyword.url_friendly_value)).to eq(@keyword)
  end

end
