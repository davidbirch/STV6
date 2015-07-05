require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do

  describe "GET #index" do
    before :each do
      @channel = FactoryGirl.create(:channel)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of channels" do
      expect(assigns(:channels)).to eq([@channel])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @channel = FactoryGirl.create(:channel)
      get :show, id: @channel
    end
        
    it "assigns the requested channel to @channel" do
      expect(assigns(:channel)).to eq(@channel)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Channel as @channel" do
      expect(assigns(:channel)).to be_a_new(Channel)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Channel" do
        expect {
          post :create, channel: FactoryGirl.attributes_for(:channel)
        }.to change(Channel, :count).by(1)
      end

      it "assigns a newly created channel as @channel" do
        post :create, channel: FactoryGirl.attributes_for(:channel)
        expect(assigns(:channel)).to be_a(Channel)
        expect(assigns(:channel)).to be_persisted
      end

      it "redirects to the created channel" do
        post :create, channel: FactoryGirl.attributes_for(:channel)
        expect(response).to redirect_to(Channel.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved channel as @channel" do
        post :create, channel: FactoryGirl.attributes_for(:invalid_channel)
        expect(assigns(:channel)).to be_a_new(Channel)
      end

      it "re-renders the 'new' template" do
        post :create, channel: FactoryGirl.attributes_for(:invalid_channel)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested channel as @channel" do
        channel = FactoryGirl.create(:channel)
        put :update, {:id => channel.to_param, :channel => FactoryGirl.attributes_for(:channel_seven)}
        expect(assigns(:channel)).to eq(channel)
      end

      it "redirects to the channel" do
        channel = FactoryGirl.create(:channel)
        put :update, {:id => channel.to_param, :channel => FactoryGirl.attributes_for(:channel_seven)}
        channel.reload
        expect(response).to redirect_to(channel)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        channel = FactoryGirl.create(:channel)
        put :update, {:id => channel.to_param, :channel => FactoryGirl.attributes_for(:invalid_channel)}
        expect(assigns(:channel)).to eq(channel)
      end

      it "re-renders the 'edit' template" do
        channel = FactoryGirl.create(:channel)
        put :update, {:id => channel.to_param, :channel => FactoryGirl.attributes_for(:invalid_channel)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested channel" do
      channel = FactoryGirl.create(:channel)
      expect {
        delete :destroy, {:id => channel.to_param}
      }.to change(Channel, :count).by(-1)
    end

    it "redirects to the channels list" do
      channel = FactoryGirl.create(:channel)
      delete :destroy, {:id => channel.to_param}
      expect(response).to redirect_to(channels_url)
    end
  end

end
