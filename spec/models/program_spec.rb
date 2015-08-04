# == Schema Information
#
# Table name: programs
#
#  id                    :integer          not null, primary key
#  title                 :string(255)
#  subtitle              :string(255)
#  category              :string(255)
#  description           :text(65535)
#  program_hash          :text(65535)
#  start_datetime        :datetime
#  start_date_display    :string(255)
#  end_datetime          :datetime
#  region_id             :integer
#  channel_id            :integer
#  sport_id              :integer
#  keyword_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  url_friendly_category :string(255)
#

require 'rails_helper'

RSpec.describe Program, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end
  
  it "is invalid without a title" do
    expect(FactoryGirl.build(:program, title: nil)).to validate_presence_of(:title)
  end
    
  it "is invalid without a start date/time" do
    expect(FactoryGirl.build(:program, start_datetime: nil)).to validate_presence_of(:start_datetime)
  end
  
  it "is invalid without an end date/time" do
    expect(FactoryGirl.build(:program, end_datetime: nil)).to validate_presence_of(:end_datetime)
  end
  
  it "is invalid without a region_id" do
    expect(FactoryGirl.build(:program, region_id: nil)).to validate_presence_of(:region_id)
  end
  
  it "is invalid without a sport_id" do
    expect(FactoryGirl.build(:program, sport_id: nil)).to validate_presence_of(:sport_id)
  end

  it "is invalid without a keyword_id" do
    expect(FactoryGirl.build(:program, keyword_id: nil)).to validate_presence_of(:keyword_id)
  end
  
  it "is invalid without a channel_id" do
    expect(FactoryGirl.build(:program, channel_id: nil)).to validate_presence_of(:channel_id)
  end
    
  it "should belong to a region" do
    expect(FactoryGirl.build(:program)).to belong_to(:region)
  end  
  
  it "should belong to a channel" do
    expect(FactoryGirl.build(:program)).to belong_to(:channel)
  end
  
  it "should belong to a sport" do
    expect(FactoryGirl.build(:program)).to belong_to(:sport)
  end

  it "should belong to a keyword" do
    expect(FactoryGirl.build(:program)).to belong_to(:keyword)
  end

  it "should set the start_date_display" do
    @program = FactoryGirl.create(:program)
    expect(@program.start_date_display).to eq(@program.start_datetime.strftime("%F"))
  end
  
  it "should set the url_friendly_category" do
    @program = FactoryGirl.create(:program)
    expect(@program.url_friendly_category).to eq(@program.category.parameterize)
  end
  
  it "is invalid without a unique channel/region/sport/start/end" do
    expect(FactoryGirl.build(:program)).to validate_uniqueness_of(:channel_id).scoped_to(:region_id, :title, :sport_id, :start_datetime, :end_datetime)
  end
  
  describe "should validate the uniqueness of channel for a specified region, title, sport, start_datetime, and end_datetime" do
    
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @sport_tennis = FactoryGirl.create(:tennis_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @channel_seven = FactoryGirl.create(:channel_seven)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @region_brisbane = FactoryGirl.create(:region_brisbane)
      @keyword = FactoryGirl.create(:keyword)
      
      @program_1 = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id)
    end
    
    context "where they all match" do
      it "does not create a duplicate program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id).valid?).to be false
      end
    end
    
    context "where the channel is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_seven.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id).valid?).to be true
      end
    end
    
    context "where the sport is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_tennis.id, keyword_id: @keyword.id).valid?).to be true
      end
    end
        
    context "where the region is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_brisbane.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id).valid?).to be true
      end
    end
    
    context "where the title is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, title: "Some other title").valid?).to be true
      end
    end
   
    context "where the start_datetime is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, start_datetime: TEN_PM_YESTERDAY_PROG).valid?).to be true
      end
    end
   
    context "where the end_datetime is different" do
      it "creates a program" do
        expect(FactoryGirl.build(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, end_datetime: ELEVEN_PM_YESTERDAY_PROG).valid?).to be true  
      end
    end  
  end
  
    describe "can create a program based on a raw program" do
    
    before :each do
      ["Cricket","Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
        FactoryGirl.create(:sport, name: e)
        }
      ["Cricket","Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
        FactoryGirl.create(:keyword, value: e, sport_id: Sport.find_by_name(e).id)
        }
      FactoryGirl.create(:channel_seven)
      FactoryGirl.create(:channel_nine)
      FactoryGirl.create(:region_brisbane)
      FactoryGirl.create(:region_melbourne)
     end
    
    context "where the program already exists" do
      it "does not create a duplicate program" do
        raw_program_cricket = FactoryGirl.create(:cricket_raw_program)
        program_1 = Program.create_from_raw_program(raw_program_cricket)
        expect(Program.create_from_raw_program(raw_program_cricket).new_record?).to be true
      end
    end
        
    context "where the program does not exist" do
      it "creates a new program" do
        raw_program_tennis = FactoryGirl.create(:cricket_raw_program, region_name: "Melbourne", channel_name: "Nine", category: "Tennis")
        expect(Program.create_from_raw_program(raw_program_tennis).new_record?).to be false
      end 
    end
    
    context "where the sport needs to match the ruleset" do
      it "sets the sport to 'Cricket'" do
        raw_program_cricket = FactoryGirl.create(:cricket_raw_program)
        program = Program.create_from_raw_program(raw_program_cricket)
        expect(program.sport).to eq(Sport.find_by_name("Cricket"))
      end

      it "sets the sport to 'Rugby League'" do
        raw_program_rugby_league = FactoryGirl.create(:rugby_league_raw_program)
        program = Program.create_from_raw_program(raw_program_rugby_league)
        expect(program.sport).to eq(Sport.find_by_name("Rugby League"))
      end
      
      it "sets the sport to 'Tennis'" do
        raw_program_tennis = FactoryGirl.create(:tennis_raw_program)
        program = Program.create_from_raw_program(raw_program_tennis)
        expect(program.sport).to eq(Sport.find_by_name("Tennis"))
      end
      
       it "sets the sport to 'Tennis' when the category contains punctuation" do
        raw_program_tennis = FactoryGirl.create(:valid_raw_program, category: 'Sports, Tennis, Sports Group')
        program = Program.create_from_raw_program(raw_program_tennis)
        expect(program.sport).to eq(Sport.find_by_name("Tennis"))
      end
      
      it "sets the sport to 'Other Sport'" do
        other_sport_raw_program = FactoryGirl.create(:other_sport_raw_program)
        program = Program.create_from_raw_program(other_sport_raw_program)
        expect(program.sport).to eq(Sport.find_by_name("Other Sport"))
      end
      
      it "doesn't create a program because it is a Sport/News program" do
        news_raw_program = FactoryGirl.create(:news_raw_program)
        program = Program.create_from_raw_program(news_raw_program)
        expect(program).not_to be_valid
      end
      
      it "doesn't create a program because it is a non-sport program" do
        non_sport_raw_program = FactoryGirl.create(:non_sport_raw_program)
        program = Program.create_from_raw_program(non_sport_raw_program)
        expect(program).not_to be_valid
      end 
    end
      
  end
  
end
