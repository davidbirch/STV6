# == Schema Information
#
# Table name: regions
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  timezone_adjustment :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  url_friendly_name   :string(255)
#

require 'rails_helper'

RSpec.describe Region, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:region)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryGirl.build(:region, name: nil)).to_not be_valid
  end
 
  it "is invalid without a unique name" do
    expect(FactoryGirl.build(:region)).to validate_uniqueness_of(:name)
  end
  
  it "should have many programs" do
    expect(FactoryGirl.build(:region)).to have_many(:programs)
  end
    
end
