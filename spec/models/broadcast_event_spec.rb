# == Schema Information
#
# Table name: broadcast_events
#
#  id                         :integer          not null, primary key
#  program_id                 :integer
#  broadcast_service_id       :integer
#  broadcast_event_hash       :text(65535)
#  epoch_scheduled_date       :integer
#  formatted_local_start_date :string(255)
#  formatted_scheduled_date   :datetime
#  formatted_end_date         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'rails_helper'

RSpec.describe BroadcastEvent, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:broadcast_event)).to be_valid
  end
  
  it "is invalid without a program" do
    expect(FactoryGirl.build(:broadcast_event, program_id: nil)).to validate_presence_of(:program_id)
  end
  
  it "is invalid without a broadcast_service" do
    expect(FactoryGirl.build(:broadcast_event, broadcast_service_id: nil)).to validate_presence_of(:broadcast_service_id)
  end

  it "is invalid without an epoch scheduled date" do
    expect(FactoryGirl.build(:broadcast_event, epoch_scheduled_date: nil)).to validate_presence_of(:epoch_scheduled_date)
  end
  
  it "is invalid without a unique program/broadcast_service/epoch_schedule_daten" do
    expect(FactoryGirl.build(:broadcast_event)).to validate_uniqueness_of(:program_id).scoped_to(:broadcast_service_id, :epoch_scheduled_date)
  end

  it "should belong to a program" do
    expect(FactoryGirl.build(:broadcast_event)).to belong_to(:program)
  end  
  
  it "should belong to a broadcast_service" do
    expect(FactoryGirl.build(:broadcast_event)).to belong_to(:broadcast_service)
  end

  it "should have one region through a broadcast_service" do
    expect(FactoryGirl.build(:broadcast_event)).to have_one(:region).through(:broadcast_service)
  end

  it "should have one channel through a broadcast_service" do
    expect(FactoryGirl.build(:broadcast_event)).to have_one(:channel).through(:broadcast_service)
  end
  
  it "should have one sport through a keyword" do
    expect(FactoryGirl.build(:broadcast_event)).to have_one(:sport).through(:keyword)
  end
  
  it "should have one keyword through a program" do
    expect(FactoryGirl.build(:broadcast_event)).to have_one(:keyword).through(:program)
  end
  
  describe "should create from a raw program" do
  
    before :each do
      @region = FactoryGirl.create(:region_adelaide) # Adelaide
      @provider = FactoryGirl.create(:freeview_provider) # Freeview
      @raw_channel = FactoryGirl.create(:raw_channel_including_hash)
      @channel = Channel.create_from_raw_channel(@raw_channel) # Adelaide / NIA / Channel Nine Adelaide / 20480
      @broadcast_service = BroadcastService.create_from_raw_channel(@raw_channel) 
      
      ["Cricket", "Golf", "Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
        FactoryGirl.create(:sport, name: e)
        }
      ["Cricket", "Golf", "Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
        FactoryGirl.create(:keyword, value: e, sport_id: Sport.find_by_name(e).id)
        }        
      @raw_program = FactoryGirl.create(:raw_program_including_hash) # Adelaide / NIA / Golf: The Players: 2008 Garcia
      @program = Program.create_from_raw_program(@raw_program)    
    end
  
    it "can be created from a raw channel" do
      expect(BroadcastEvent.create_from_raw_program(@raw_program).new_record?).to be false
    end
    
    it "has valid associated broadcast_service and program" do
      @broadcast_event = BroadcastEvent.create_from_raw_program(@raw_program)
      expect(@broadcast_event.program).to eq(@program)
      expect(@broadcast_event.broadcast_service).to eq(@broadcast_service)
    end 
    
  end
    
end
