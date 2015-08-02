require 'rails_helper'

RSpec.describe ProgramCategoriesController, type: :controller do
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
      expect(assigns(:programs_by_category)).to eq(Program.group(:url_friendly_category).order("count_all DESC").count)
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end  
  end
  
   describe "GET #show where the category does match" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :show, id: @program.url_friendly_category
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
  
  describe "GET #show where the category does not match" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :show, id: "diff"
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
