# == Schema Information
#
# Table name: raw_channels
#
#  id            :integer          not null, primary key
#  channel_hash  :text(65535)
#  channel_name  :string(255)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe RawChannelsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

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
      get :show, params:{id: @raw_channel}
    end
        
    it "assigns the requested raw_channel to @raw_channel" do
      expect(assigns(:raw_channel)).to eq(@raw_channel)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
