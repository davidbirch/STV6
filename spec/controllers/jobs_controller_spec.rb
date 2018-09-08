require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end
 
  describe "GET #index" do
    before :each do
      @job = FactoryGirl.create(:job)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of jobs" do
      expect(assigns(:jobs)).to eq([@job])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end  
  end

  describe "GET #show" do
    before :each do
      @job = FactoryGirl.create(:job)
      get :show, params:{id: @job}
    end
        
    it "assigns the requested migrator to @job" do
      expect(assigns(:job)).to eq(@job)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
