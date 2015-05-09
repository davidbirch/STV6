require 'rails_helper'

RSpec.describe RawProgram, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_program)).to be_valid
  end  
  
end
