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

RSpec.describe ChannelShortNamesController, type: :controller do
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
  
   describe "GET #show where the short name does match" do
    before :each do
      @channel = FactoryGirl.create(:channel)
      get :show, params:{id: @channel.url_friendly_short_name}
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
        
    it "populates an array of channels" do
      expect(assigns(:channels)).to match_array([@channel])
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
   
  describe "GET #show where the short name doesn't match" do
    before :each do
      @channel = FactoryGirl.create(:channel)
      get :show, params:{id: "diff"}
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
        
    it "does not populate an array of channels" do
      expect(assigns(:channels)).to match_array([])
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
