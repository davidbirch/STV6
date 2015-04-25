require "rails_helper"

RSpec.describe RawChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw_channels").to route_to("raw_channels#index")
    end

    it "routes to #new" do
      expect(:get => "/raw_channels/new").to route_to("raw_channels#new")
    end

    it "routes to #show" do
      expect(:get => "/raw_channels/1").to route_to("raw_channels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/raw_channels/1/edit").to route_to("raw_channels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/raw_channels").to route_to("raw_channels#create")
    end

    it "routes to #update" do
      expect(:put => "/raw_channels/1").to route_to("raw_channels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/raw_channels/1").to route_to("raw_channels#destroy", :id => "1")
    end

  end
end
