require 'rails_helper'

RSpec.describe ConversionSummariesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:valid_user)
    session[:user_id] = @user.id
  end

   describe "GET #index" do
    before :each do
      @conversion_summary = FactoryGirl.create(:conversion_summary)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of conversion_summarys" do
      expect(assigns(:conversion_summaries)).to eq([@conversion_summary])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @conversion_summary = FactoryGirl.create(:conversion_summary)
      get :show, id: @conversion_summary
    end
        
    it "assigns the requested conversion_summary to @conversion_summary" do
      expect(assigns(:conversion_summary)).to eq(@conversion_summary)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
