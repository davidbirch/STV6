# == Schema Information
#
# Table name: raw_programs
#
#  id            :integer          not null, primary key
#  program_hash  :text(65535)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  placeholder   :boolean
#  title         :string(255)
#  event_lookup  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe RawProgram, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:raw_program)).to be_valid
  end
  
  it "has a valid factory including a program hash" do
    expect(FactoryGirl.create(:raw_program_including_hash)).to be_valid
  end
  
  it "is invalid without a region_name" do
    expect(FactoryGirl.build(:raw_program, region_lookup: nil)).to validate_presence_of(:region_lookup)
  end

  it "is invalid without a region_name" do
    expect(FactoryGirl.build(:raw_program, region_name: nil)).to validate_presence_of(:region_name)
  end
    
  it "is invalid without a channel tag" do
    expect(FactoryGirl.build(:raw_program, channel_tag: nil)).to validate_presence_of(:channel_tag)
  end

end
