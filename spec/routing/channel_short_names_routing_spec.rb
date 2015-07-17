require "rails_helper"

RSpec.describe ChannelShortNamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/channels-by-short-name").to route_to("channel_short_names#index")
    end

    it "routes to #show" do
      expect(:get => "/channels-by-short-name/fox1").to route_to("channel_short_names#show", :id => "fox1")
    end

  end
end
