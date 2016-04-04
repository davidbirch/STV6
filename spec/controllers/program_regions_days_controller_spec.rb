require 'rails_helper'

RSpec.describe ProgramRegionsDaysController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @program = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id)
    
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
        
    it "populates an array of regions" do
      expect(assigns(:regions)).to eq([@region_melbourne])
    end

    it "populates an array of days" do
      expect(assigns(:programs_by_day)).to eq(Program.group(:start_date_display).order("start_date_display ASC").count)
    end    
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end  
  end
     
end
