require 'rails_helper'

RSpec.describe SportsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:valid_user)
    session[:user_id] = @user.id
  end
    
  describe "GET #index" do
    before :each do
      @sport = FactoryGirl.create(:sport)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of sports" do
      expect(assigns(:sports)).to eq([@sport])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @sport = FactoryGirl.create(:sport)
      get :show, id: @sport
    end
        
    it "assigns the requested sport to @sport" do
      expect(assigns(:sport)).to eq(@sport)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Sport as @sport" do
      expect(assigns(:sport)).to be_a_new(Sport)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Sport" do
        expect {
          post :create, sport: FactoryGirl.attributes_for(:sport)
        }.to change(Sport, :count).by(1)
      end

      it "assigns a newly created sport as @sport" do
        post :create, sport: FactoryGirl.attributes_for(:sport)
        expect(assigns(:sport)).to be_a(Sport)
        expect(assigns(:sport)).to be_persisted
      end

      it "redirects to the created sport" do
        post :create, sport: FactoryGirl.attributes_for(:sport)
        expect(response).to redirect_to(Sport.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved sport as @sport" do
        post :create, sport: FactoryGirl.attributes_for(:invalid_sport)
        expect(assigns(:sport)).to be_a_new(Sport)
      end

      it "re-renders the 'new' template" do
        post :create, sport: FactoryGirl.attributes_for(:invalid_sport)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested sport as @sport" do
        sport = FactoryGirl.create(:sport)
        put :update, {:id => sport.to_param, :sport => FactoryGirl.attributes_for(:cricket_sport)}
        expect(assigns(:sport)).to eq(sport)
      end

      it "redirects to the sport" do
        sport = FactoryGirl.create(:sport)
        put :update, {:id => sport.to_param, :sport => FactoryGirl.attributes_for(:cricket_sport)}
        sport.reload
        expect(response).to redirect_to(sport)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        sport = FactoryGirl.create(:sport)
        put :update, {:id => sport.to_param, :sport => FactoryGirl.attributes_for(:invalid_sport)}
        expect(assigns(:sport)).to eq(sport)
      end

      it "re-renders the 'edit' template" do
        sport = FactoryGirl.create(:sport)
        put :update, {:id => sport.to_param, :sport => FactoryGirl.attributes_for(:invalid_sport)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested sport" do
      sport = FactoryGirl.create(:sport)
      expect {
        delete :destroy, {:id => sport.to_param}
      }.to change(Sport, :count).by(-1)
    end

    it "redirects to the sports list" do
      sport = FactoryGirl.create(:sport)
      delete :destroy, {:id => sport.to_param}
      expect(response).to redirect_to(sports_url)
    end
  end

end
