require 'rails_helper'

RSpec.describe RawChannel, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_channel)).to be_valid
  end  
  
end
