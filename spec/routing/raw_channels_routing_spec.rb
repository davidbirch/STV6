require "rails_helper"

RSpec.describe RawChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-channels").to route_to("raw_channels#index")
    end

    it "routes to #show" do
      expect(:get => "/raw-channels/1").to route_to("raw_channels#show", :id => "1")
    end

  end
end
