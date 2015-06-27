require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  describe "GET #index" do
    before :each do
      @region = FactoryGirl.create(:region)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of regions" do
      expect(assigns(:regions)).to eq([@region])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @region = FactoryGirl.create(:region)
      get :show, id: @region
    end
        
    it "assigns the requested region to @region" do
      expect(assigns(:region)).to eq(@region)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Region as @region" do
      expect(assigns(:region)).to be_a_new(Region)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Region" do
        expect {
          post :create, region: FactoryGirl.attributes_for(:region)
        }.to change(Region, :count).by(1)
      end

      it "assigns a newly created region as @region" do
        post :create, region: FactoryGirl.attributes_for(:region)
        expect(assigns(:region)).to be_a(Region)
        expect(assigns(:region)).to be_persisted
      end

      it "redirects to the created region" do
        post :create, region: FactoryGirl.attributes_for(:region)
        expect(response).to redirect_to(Region.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved region as @region" do
        post :create, region: FactoryGirl.attributes_for(:invalid_region)
        expect(assigns(:region)).to be_a_new(Region)
      end

      it "re-renders the 'new' template" do
        post :create, region: FactoryGirl.attributes_for(:invalid_region)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested region as @region" do
        region = FactoryGirl.create(:region)
        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region_melbourne)}
        expect(assigns(:region)).to eq(region)
      end

      it "redirects to the region" do
        region = FactoryGirl.create(:region)
        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:region_melbourne)}
        region.reload
        expect(response).to redirect_to(region)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        region = FactoryGirl.create(:region)
        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:invalid_region)}
        expect(assigns(:region)).to eq(region)
      end

      it "re-renders the 'edit' template" do
        region = FactoryGirl.create(:region)
        put :update, {:id => region.to_param, :region => FactoryGirl.attributes_for(:invalid_region)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested region" do
      region = FactoryGirl.create(:region)
      expect {
        delete :destroy, {:id => region.to_param}
      }.to change(Region, :count).by(-1)
    end

    it "redirects to the regions list" do
      region = FactoryGirl.create(:region)
      delete :destroy, {:id => region.to_param}
      expect(response).to redirect_to(regions_url)
    end
  end

end
