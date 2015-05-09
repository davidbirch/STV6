require 'rails_helper'

RSpec.describe RawChannelsController, type: :controller do
 
  describe "GET #index" do
    before :each do
      @raw_channel = FactoryGirl.create(:raw_channel)
      get :index
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of raw_channels" do
      expect(assigns(:raw_channels)).to eq([@raw_channel])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end
  
  describe "GET #show" do
    before :each do
      @raw_channel = FactoryGirl.create(:raw_channel)
      get :show, id: @raw_channel
    end
        
    it "assigns the requested raw_channel to @raw_channel" do
      expect(assigns(:raw_channel)).to eq(@raw_channel)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new RawChannel as @raw_channel" do
      expect(assigns(:raw_channel)).to be_a_new(RawChannel)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RawChannel" do
        expect {
          post :create, raw_channel: FactoryGirl.attributes_for(:raw_channel)
        }.to change(RawChannel, :count).by(1)
      end

      it "assigns a newly created raw_channel as @raw_channel" do
        post :create, raw_channel: FactoryGirl.attributes_for(:raw_channel)
        expect(assigns(:raw_channel)).to be_a(RawChannel)
        expect(assigns(:raw_channel)).to be_persisted
      end

      it "redirects to the created raw_channel" do
        post :create, raw_channel: FactoryGirl.attributes_for(:raw_channel)
        expect(response).to redirect_to(RawChannel.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved raw_channel as @raw_channel" do
        post :create, raw_channel: FactoryGirl.attributes_for(:invalid_raw_channel)
        expect(assigns(:raw_channel)).to be_a_new(RawChannel)
      end

      it "re-renders the 'new' template" do
        post :create, raw_channel: FactoryGirl.attributes_for(:invalid_raw_channel)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested raw_channel as @raw_channel" do
        raw_channel = FactoryGirl.create(:raw_channel)
        put :update, {:id => raw_channel.to_param, :raw_channel => FactoryGirl.attributes_for(:raw_channel_seven)}
        expect(assigns(:raw_channel)).to eq(raw_channel)
      end

      it "redirects to the raw_channel" do
        raw_channel = FactoryGirl.create(:raw_channel)
        put :update, {:id => raw_channel.to_param, :raw_channel => FactoryGirl.attributes_for(:raw_channel_seven)}
        expect(response).to redirect_to(raw_channel)
      end
    end

    context "with invalid params" do
      it "assigns the raw_channel as @raw_channel" do
        raw_channel = FactoryGirl.create(:raw_channel)
        put :update, {:id => raw_channel.to_param, :raw_channel => FactoryGirl.attributes_for(:invalid_raw_channel)}
        expect(assigns(:raw_channel)).to eq(raw_channel)
      end

      it "re-renders the 'edit' template" do
        raw_channel = FactoryGirl.create(:raw_channel)
        put :update, {:id => raw_channel.to_param, :raw_channel => FactoryGirl.attributes_for(:invalid_raw_channel)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested raw_channel" do
      raw_channel = FactoryGirl.create(:raw_channel)
      expect {
        delete :destroy, {:id => raw_channel.to_param}
      }.to change(RawChannel, :count).by(-1)
    end

    it "redirects to the raw_channels list" do
      raw_channel = FactoryGirl.create(:raw_channel)
      delete :destroy, {:id => raw_channel.to_param}
      expect(response).to redirect_to(raw_channels_url)
    end
  end

end
