require 'rails_helper'

RSpec.describe ProgramDaysController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:valid_user)
    session[:user_id] = @user.id
  end

  describe "GET #index" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of programs" do
      expect(assigns(:programs_by_day)).to eq(Program.group(:start_date_display).order("start_date_display ASC").count)
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end  
  end
  
   describe "GET #show where the date does match" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :show, id: @program.start_date_display
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
        
    it "populates an array of programs" do
      expect(assigns(:programs)).to match_array([@program])
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #show where the date does not match" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :show, id: "2012-07-14"
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
        
    it "does not populate an array of programs" do
      expect(assigns(:programs)).to match_array([])
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
   
end
