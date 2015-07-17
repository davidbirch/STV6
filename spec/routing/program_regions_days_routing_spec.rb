require "rails_helper"

RSpec.describe ProgramRegionsDaysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs-by-region-and-day").to route_to("program_regions_days#index")
    end

  end
end
