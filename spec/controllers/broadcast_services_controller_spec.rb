# == Schema Information
#
# Table name: broadcast_services
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe BroadcastServicesController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @broadcast_service = FactoryGirl.create(:broadcast_service)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of broadcast_services" do
      expect(assigns(:broadcast_services)).to eq([@broadcast_service])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @broadcast_service = FactoryGirl.create(:broadcast_service)
      get :show, params:{id: @broadcast_service}
    end
        
    it "assigns the requested broadcast_service to @broadcast_service" do
      expect(assigns(:broadcast_service)).to eq(@broadcast_service)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new BroadcastService as @broadcast_service" do
      expect(assigns(:broadcast_service)).to be_a_new(BroadcastService)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Broadcast Service" do
        expect {
          post :create, params:{broadcast_service: FactoryGirl.attributes_for(:broadcast_service)}
        }.to change(BroadcastService, :count).by(1)
      end

      it "assigns a newly created broadcast_service as @broadcast_service" do
        post :create, params:{broadcast_service: FactoryGirl.attributes_for(:broadcast_service)}
        expect(assigns(:broadcast_service)).to be_a(BroadcastService)
        expect(assigns(:broadcast_service)).to be_persisted
      end

      it "redirects to the created broadcast_service" do
        post :create, params:{broadcast_service: FactoryGirl.attributes_for(:broadcast_service)}
        expect(response).to redirect_to(BroadcastService.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved broadcast_service as @broadcast_service" do
        post :create, params:{broadcast_service: FactoryGirl.attributes_for(:invalid_broadcast_service)}
        expect(assigns(:broadcast_service)).to be_a_new(BroadcastService)
      end

      it "re-renders the 'new' template" do
        post :create, params:{broadcast_service: FactoryGirl.attributes_for(:invalid_broadcast_service)}
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested broadcast_service as @broadcast_service" do
        broadcast_service = FactoryGirl.create(:broadcast_service)
        put :update, params:{:id => broadcast_service.to_param, :broadcast_service => FactoryGirl.attributes_for(:broadcast_service_two)}
        expect(assigns(:broadcast_service)).to eq(broadcast_service)
      end

      it "redirects to the broadcast_service" do
        broadcast_service = FactoryGirl.create(:broadcast_service)
        put :update, params:{:id => broadcast_service.to_param, :broadcast_service => FactoryGirl.attributes_for(:broadcast_service_two)}
        broadcast_service.reload
        expect(response).to redirect_to(broadcast_service)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        broadcast_service = FactoryGirl.create(:broadcast_service)
        put :update, params:{:id => broadcast_service.to_param, :broadcast_service => FactoryGirl.attributes_for(:invalid_broadcast_service)}
        expect(assigns(:broadcast_service)).to eq(broadcast_service)
      end

      it "re-renders the 'edit' template" do
        broadcast_service = FactoryGirl.create(:broadcast_service)
        put :update, params:{:id => broadcast_service.to_param, :broadcast_service => FactoryGirl.attributes_for(:invalid_broadcast_service)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested broadcast_service" do
      broadcast_service = FactoryGirl.create(:broadcast_service)
      expect {
        delete :destroy, params:{:id => broadcast_service.to_param}
      }.to change(BroadcastService, :count).by(-1)
    end

    it "redirects to the broadcast_services list" do
      broadcast_service = FactoryGirl.create(:broadcast_service)
      delete :destroy, params:{:id => broadcast_service.to_param}
      expect(response).to redirect_to(broadcast_services_url)
    end
  end
  
end
