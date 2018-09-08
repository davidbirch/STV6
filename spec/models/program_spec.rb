# == Schema Information
#
# Table name: programs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  episode_title :string(255)
#  keyword_id    :integer
#  duration      :integer
#  black_flag    :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Program, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end
  
  it "is invalid without a title" do
    expect(FactoryGirl.build(:program, title: nil)).to validate_presence_of(:title)
  end
  
  it "is invalid without a duration" do
    expect(FactoryGirl.build(:program, duration: nil)).to validate_presence_of(:duration)
  end

  it "is invalid without a keyword_id" do
    expect(FactoryGirl.build(:program, keyword_id: nil)).to validate_presence_of(:keyword_id)
  end
  
  it "should belong to a keyword" do
    expect(FactoryGirl.build(:program)).to belong_to(:keyword)
  end
  
  it "should have many broadcast_events" do
    expect(FactoryGirl.build(:program)).to have_many(:broadcast_events)
  end
  
  it "is invalid without a unique title scope to episode_title and duration" do
    expect(FactoryGirl.build(:program)).to validate_uniqueness_of(:title).scoped_to(:episode_title, :duration)
  end
    
  describe "should validate the uniqueness of title for a specified episode_title" do
    
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
    end
  
    context "where they all match" do
      it "does not create a program" do
        Program.create_from_raw_program(@raw_program)    
        Program.create_from_raw_program(@raw_program)    
        expect(Program.count).to be(1)
      end
    end
  
  end

end
