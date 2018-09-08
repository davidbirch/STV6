# == Schema Information
#
# Table name: providers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end
    
  describe "GET #index" do
    before :each do
      @provider = FactoryGirl.create(:provider)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of providers" do
      expect(assigns(:providers)).to eq([@provider])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @provider = FactoryGirl.create(:provider)
      get :show, params:{id: @provider}
    end
        
    it "assigns the requested provider to @provider" do
      expect(assigns(:provider)).to eq(@provider)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Provider as @provider" do
      expect(assigns(:provider)).to be_a_new(Provider)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Provider" do
        expect {
          post :create, params:{provider: FactoryGirl.attributes_for(:provider)}
        }.to change(Provider, :count).by(1)
      end

      it "assigns a newly created provider as @provider" do
        post :create, params:{provider: FactoryGirl.attributes_for(:provider)}
        expect(assigns(:provider)).to be_a(Provider)
        expect(assigns(:provider)).to be_persisted
      end

      it "redirects to the created provider" do
        post :create, params:{provider: FactoryGirl.attributes_for(:provider)}
        expect(response).to redirect_to(Provider.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved provider as @provider" do
        post :create, params:{provider: FactoryGirl.attributes_for(:invalid_provider)}
        expect(assigns(:provider)).to be_a_new(Provider)
      end

      it "re-renders the 'new' template" do
        post :create, params:{provider: FactoryGirl.attributes_for(:invalid_provider)}
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested provider as @provider" do
        provider = FactoryGirl.create(:provider)
        put :update, params:{:id => provider.to_param, :provider => FactoryGirl.attributes_for(:another_provider)}
        expect(assigns(:provider)).to eq(provider)
      end

      it "redirects to the provider" do
        provider = FactoryGirl.create(:provider)
        put :update, params:{:id => provider.to_param, :provider => FactoryGirl.attributes_for(:another_provider)}
        provider.reload
        expect(response).to redirect_to(provider)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        provider = FactoryGirl.create(:provider)
        put :update, params:{:id => provider.to_param, :provider => FactoryGirl.attributes_for(:invalid_provider)}
        expect(assigns(:provider)).to eq(provider)
      end

      it "re-renders the 'edit' template" do
        provider = FactoryGirl.create(:provider)
        put :update, params:{:id => provider.to_param, :provider => FactoryGirl.attributes_for(:invalid_provider)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested provider" do
      provider = FactoryGirl.create(:provider)
      expect {
        delete :destroy, params:{:id => provider.to_param}
      }.to change(Provider, :count).by(-1)
    end

    it "redirects to the providers list" do
      provider = FactoryGirl.create(:provider)
      delete :destroy, params:{:id => provider.to_param}
      expect(response).to redirect_to(providers_url)
    end
  end

end
