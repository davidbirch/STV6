# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:category)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryGirl.build(:category, name: nil)).to_not be_valid
  end
 
  it "is invalid without a unique name" do
    expect(FactoryGirl.build(:category)).to validate_uniqueness_of(:name)
  end
  
  it "should have many programs" do
    expect(FactoryGirl.build(:category)).to have_many(:programs)
  end
  
  it "sets a url friendly name" do
    @category = FactoryGirl.create(:category)
    expect(@category.url_friendly_name).to eq(@category.name.parameterize)
  end
  
  it "can be found by the friendly id" do
    @category = FactoryGirl.create(:category)
    expect(Category.find(@category.id)).to eq(@category)
    expect(Category.friendly.find(@category.id)).to eq(@category)
    expect(Category.friendly.find(@category.url_friendly_name)).to eq(@category)
  end
  
end
