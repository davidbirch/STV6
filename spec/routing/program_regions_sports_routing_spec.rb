require "rails_helper"

RSpec.describe ProgramRegionsSportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs-by-region-and-sport").to route_to("program_regions_sports#index")
    end

  end
end
