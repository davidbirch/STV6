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

require "rails_helper"

RSpec.describe ChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/channels").to route_to("channels#index")
    end

    it "routes to #new" do
      expect(:get => "/channels/new").to route_to("channels#new")
    end

    it "routes to #show" do
      expect(:get => "/channels/1").to route_to("channels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/channels/1/edit").to route_to("channels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/channels").to route_to("channels#create")
    end

    it "routes to #update" do
      expect(:put => "/channels/1").to route_to("channels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/channels/1").to route_to("channels#destroy", :id => "1")
    end
    
    it "routes to #set_black_flag_on" do
      expect(:put => "/channels/1/set_black_flag_on").to route_to("channels#set_black_flag_on", :id => "1")
    end
    
    it "routes to #set_black_flag_off" do
      expect(:put => "/channels/1/set_black_flag_off").to route_to("channels#set_black_flag_off", :id => "1")
    end

  end
end
