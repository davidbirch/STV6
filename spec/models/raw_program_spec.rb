# == Schema Information
#
# Table name: raw_programs
#
#  id                  :integer          not null, primary key
#  program_hash        :text(65535)
#  title               :string(255)
#  subtitle            :string(255)
#  category            :string(255)
#  description         :text(65535)
#  start_datetime      :datetime
#  end_datetime        :datetime
#  region_name         :string(255)
#  channel_name        :string(255)
#  channel_free_or_pay :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe RawProgram, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_program)).to be_valid
  end
  
  it "is invalid without a title" do
    expect(FactoryGirl.build(:raw_program, title: nil)).to validate_presence_of(:title)
  end
  
  it "is invalid without a region_name" do
    expect(FactoryGirl.build(:raw_program, region_name: nil)).to validate_presence_of(:region_name)
  end
  
  it "is invalid without a channel_name" do
    expect(FactoryGirl.build(:raw_program, channel_name: nil)).to validate_presence_of(:channel_name)
  end
    
  it "is invalid without a start date/time" do
    expect(FactoryGirl.build(:raw_program, start_datetime: nil)).to validate_presence_of(:start_datetime)
  end
  
  it "is invalid without an end date/time" do
    expect(FactoryGirl.build(:raw_program, end_datetime: nil)).to validate_presence_of(:end_datetime)
  end
      
end
