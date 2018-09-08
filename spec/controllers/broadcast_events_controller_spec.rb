# == Schema Information
#
# Table name: broadcast_events
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe BroadcastEventsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @broadcast_event = FactoryGirl.create(:broadcast_event)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of broadcast_events" do
      expect(assigns(:broadcast_events)).to eq([@broadcast_event])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @broadcast_event = FactoryGirl.create(:broadcast_event)
      get :show, params:{id: @broadcast_event}
    end
        
    it "assigns the requested broadcast_event to @broadcast_event" do
      expect(assigns(:broadcast_event)).to eq(@broadcast_event)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new BroadcastEvent as @broadcast_event" do
      expect(assigns(:broadcast_event)).to be_a_new(BroadcastEvent)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Broadcast Service" do
        expect {
          post :create, params:{broadcast_event: FactoryGirl.attributes_for(:broadcast_event)}
        }.to change(BroadcastEvent, :count).by(1)
      end

      it "assigns a newly created broadcast_event as @broadcast_event" do
        post :create, params:{broadcast_event: FactoryGirl.attributes_for(:broadcast_event)}
        expect(assigns(:broadcast_event)).to be_a(BroadcastEvent)
        expect(assigns(:broadcast_event)).to be_persisted
      end

      it "redirects to the created broadcast_event" do
        post :create, params:{broadcast_event: FactoryGirl.attributes_for(:broadcast_event)}
        expect(response).to redirect_to(BroadcastEvent.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved broadcast_event as @broadcast_event" do
        post :create, params:{broadcast_event: FactoryGirl.attributes_for(:invalid_broadcast_event)}
        expect(assigns(:broadcast_event)).to be_a_new(BroadcastEvent)
      end

      it "re-renders the 'new' template" do
        post :create, params:{broadcast_event: FactoryGirl.attributes_for(:invalid_broadcast_event)}
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested broadcast_event as @broadcast_event" do
        broadcast_event = FactoryGirl.create(:broadcast_event)
        put :update, params:{:id => broadcast_event.to_param, :broadcast_event => FactoryGirl.attributes_for(:broadcast_event_two)}
        expect(assigns(:broadcast_event)).to eq(broadcast_event)
      end

      it "redirects to the broadcast_event" do
        broadcast_event = FactoryGirl.create(:broadcast_event)
        put :update, params:{:id => broadcast_event.to_param, :broadcast_event => FactoryGirl.attributes_for(:broadcast_event_two)}
        broadcast_event.reload
        expect(response).to redirect_to(broadcast_event)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        broadcast_event = FactoryGirl.create(:broadcast_event)
        put :update, params:{:id => broadcast_event.to_param, :broadcast_event => FactoryGirl.attributes_for(:invalid_broadcast_event)}
        expect(assigns(:broadcast_event)).to eq(broadcast_event)
      end

      it "re-renders the 'edit' template" do
        broadcast_event = FactoryGirl.create(:broadcast_event)
        put :update, params:{:id => broadcast_event.to_param, :broadcast_event => FactoryGirl.attributes_for(:invalid_broadcast_event)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested broadcast_event" do
      broadcast_event = FactoryGirl.create(:broadcast_event)
      expect {
        delete :destroy, params:{:id => broadcast_event.to_param}
      }.to change(BroadcastEvent, :count).by(-1)
    end

    it "redirects to the broadcast_events list" do
      broadcast_event = FactoryGirl.create(:broadcast_event)
      delete :destroy, params:{:id => broadcast_event.to_param}
      expect(response).to redirect_to(broadcast_events_url)
    end
  end
  
end
