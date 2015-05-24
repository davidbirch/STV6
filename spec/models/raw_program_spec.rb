# == Schema Information
#
# Table name: raw_programs
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  subtitle         :string(255)
#  category         :string(255)
#  description      :string(255)
#  start_datetime   :datetime
#  end_datetime     :datetime
#  region_name      :string(255)
#  channel_xmltv_id :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
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
  
  it "is invalid without a channel_xmltv_id" do
    expect(FactoryGirl.build(:raw_program, channel_xmltv_id: nil)).to validate_presence_of(:channel_xmltv_id)
  end
    
  it "is invalid without a start date/time" do
    expect(FactoryGirl.build(:raw_program, start_datetime: nil)).to validate_presence_of(:start_datetime)
  end
  
  it "is invalid without an end date/time" do
    expect(FactoryGirl.build(:raw_program, end_datetime: nil)).to validate_presence_of(:end_datetime)
  end
    
  describe "can select all historic raw_programs" do
      
    context "where the program is in the future" do
      it "should not return an array containing the valid raw programs" do
        valid_raw_program = FactoryGirl.create(:valid_raw_program)
        historic_raw_programs = RawProgram.historic || []
        expect(historic_raw_programs).not_to include(valid_raw_program) 
      end
    end
        
    context "where the program is in the past" do
      it "is should return an array containing the historic raw program" do
        historic_raw_program = FactoryGirl.create(:historic_raw_program)
        historic_raw_programs = RawProgram.historic || []
        expect(historic_raw_programs).to include(historic_raw_program)
      end
    end
    
  end 
  
end
