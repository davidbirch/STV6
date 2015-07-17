require "rails_helper"

RSpec.describe ProgramRegionsChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs-by-region-and-channel").to route_to("program_regions_channels#index")
    end

  end
end
