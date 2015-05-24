# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  xmltv_id    :string(255)
#  free_or_pay :string(255)
#  name        :string(255)
#  short_name  :string(255)
#  black_flag  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
  
  it "is invalid without an xmltv id" do
    expect(FactoryGirl.build(:channel, xmltv_id: nil)).to validate_presence_of(:xmltv_id)
  end
  
  it "is invalid without a unique name" do
    expect(FactoryGirl.build(:channel)).to validate_uniqueness_of(:name)
  end
  
  it "is invalid without a unique xmltv_id" do
    expect(FactoryGirl.build(:channel)).to validate_uniqueness_of(:xmltv_id)
  end
  
  it "should have many programs" do
    expect(FactoryGirl.build(:channel)).to have_many(:programs)
  end
  
end
