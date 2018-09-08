# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  url_friendly_name       :string(255)
#  short_name              :string(255)
#  url_friendly_short_name :string(255)
#  region_id               :integer
#  provider_id             :integer
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

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
      get :show, params:{id: @channel}
    end
        
    it "assigns the requested channel to @channel" do
      expect(assigns(:channel)).to eq(@channel)
    end
    
    it "populates an array of regions" do
      expect(assigns(:regions)).to eq(@channel.regions)
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
          post :create, params:{channel: FactoryGirl.attributes_for(:channel)}
        }.to change(Channel, :count).by(1)
      end

      it "assigns a newly created channel as @channel" do
        post :create, params:{channel: FactoryGirl.attributes_for(:channel)}
        expect(assigns(:channel)).to be_a(Channel)
        expect(assigns(:channel)).to be_persisted
      end

      it "redirects to the created channel" do
        post :create, params:{channel: FactoryGirl.attributes_for(:channel)}
        expect(response).to redirect_to(Channel.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved channel as @channel" do
        post :create, params:{channel: FactoryGirl.attributes_for(:invalid_channel)}
        expect(assigns(:channel)).to be_a_new(Channel)
      end

      it "re-renders the 'new' template" do
        post :create, params:{channel: FactoryGirl.attributes_for(:invalid_channel)}
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested channel as @channel" do
        channel = FactoryGirl.create(:channel)
        put :update, params:{:id => channel.to_param, :channel => FactoryGirl.attributes_for(:channel_seven)}
        expect(assigns(:channel)).to eq(channel)
      end

      it "redirects to the channel" do
        channel = FactoryGirl.create(:channel)
        put :update, params:{:id => channel.to_param, :channel => FactoryGirl.attributes_for(:channel_seven)}
        channel.reload
        expect(response).to redirect_to(channel)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        channel = FactoryGirl.create(:channel)
        put :update, params:{:id => channel.to_param, :channel => FactoryGirl.attributes_for(:invalid_channel)}
        expect(assigns(:channel)).to eq(channel)
      end

      it "re-renders the 'edit' template" do
        channel = FactoryGirl.create(:channel)
        put :update, params:{:id => channel.to_param, :channel => FactoryGirl.attributes_for(:invalid_channel)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested channel" do
      channel = FactoryGirl.create(:channel)
      expect {
        delete :destroy, params:{:id => channel.to_param}
      }.to change(Channel, :count).by(-1)
    end

    it "redirects to the channels list" do
      channel = FactoryGirl.create(:channel)
      delete :destroy, params:{:id => channel.to_param}
      expect(response).to redirect_to(channels_url)
    end
  end
    
  describe "PUT #set_black_flag_on" do
    it "sets the black_flag field to true" do
      channel = FactoryGirl.create(:channel)
      put :set_black_flag_on, params:{:id => channel.to_param}
      channel.reload
      expect(channel.black_flag?).to be true
    end
    
    it "redirects to the channels index" do
      channel = FactoryGirl.create(:channel)
      put :set_black_flag_on, params:{:id => channel.to_param}
      channel.reload
      expect(response).to redirect_to(channels_url)
    end
  end
  
  describe "PUT #set_black_flag_off" do
    it "sets the black_flag field to false" do
      channel = FactoryGirl.create(:channel)
      put :set_black_flag_off, params:{:id => channel.to_param}
      channel.reload
      expect(channel.black_flag?).to be false
    end
    
    it "redirects to the channels index" do
      channel = FactoryGirl.create(:channel)
      put :set_black_flag_off, params:{:id => channel.to_param}
      channel.reload
      expect(response).to redirect_to(channels_url)
    end
  end

end
