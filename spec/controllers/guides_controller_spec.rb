require 'rails_helper'

RSpec.describe GuidesController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end
 
  describe "GET #index" do
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @sport_tennis = FactoryGirl.create(:tennis_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @channel_seven = FactoryGirl.create(:channel_seven)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @region_brisbane = FactoryGirl.create(:region_brisbane)
      @keyword = FactoryGirl.create(:keyword)
      @category = FactoryGirl.create(:sport_category)
      @program_1 = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, category_id: @category.id)
      
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end  
  end
  
  describe "GET #show, {:region_name = ?}" do
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @sport_tennis = FactoryGirl.create(:tennis_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @channel_seven = FactoryGirl.create(:channel_seven)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @region_brisbane = FactoryGirl.create(:region_brisbane)
      @keyword = FactoryGirl.create(:keyword)
      @category = FactoryGirl.create(:sport_category)
      @program_1 = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, category_id: @category.id)
      
      get :show, {:region_name => @region_melbourne.url_friendly_name}
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    
    it "populates a region" do
      expect(assigns(:region)).to eq(@region_melbourne)
    end
    
    it "populates a sport" do
      expect(assigns(:sport)).to eq(nil)
    end
    
    it "populates a search string" do
      expect(assigns(:search_string)).to eq(nil)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "GET #show, {:region_name = ?, sport_name = ?}" do
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @sport_tennis = FactoryGirl.create(:tennis_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @channel_seven = FactoryGirl.create(:channel_seven)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @region_brisbane = FactoryGirl.create(:region_brisbane)
      @keyword = FactoryGirl.create(:keyword)
      @category = FactoryGirl.create(:sport_category)
      @program_1 = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, category_id: @category.id)
      
      get :show, {:region_name => @region_melbourne.url_friendly_name, :sport_name => @sport_tennis.url_friendly_name}
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates a region" do
      expect(assigns(:region)).to eq(@region_melbourne)
    end
    
    it "populates a sport" do
      expect(assigns(:sport)).to eq(@sport_tennis)
    end
    
    it "populates a search string" do
      expect(assigns(:search_string)).to eq(nil)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "GET #show, {:region_name = ?, search = ?}" do
    before :each do
      @sport_cricket = FactoryGirl.create(:cricket_sport)
      @sport_tennis = FactoryGirl.create(:tennis_sport)
      @channel_nine = FactoryGirl.create(:channel_nine)
      @channel_seven = FactoryGirl.create(:channel_seven)
      @region_melbourne = FactoryGirl.create(:region_melbourne)
      @region_brisbane = FactoryGirl.create(:region_brisbane)
      @keyword = FactoryGirl.create(:keyword)
      @category = FactoryGirl.create(:sport_category)
      @program_1 = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, category_id: @category.id)
      
      get :show, {:region_name => @region_melbourne.url_friendly_name, :search => "test search"}
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end

    it "populates a region" do
      expect(assigns(:region)).to eq(@region_melbourne)
    end
    
    it "populates a sport" do
      expect(assigns(:sport)).to eq(nil)
    end
    
    it "populates a search string" do
      expect(assigns(:search_string)).to eq("test search")
    end
       
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
end
