require "rails_helper"

RSpec.describe ProgramDaysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs-by-day").to route_to("program_days#index")
    end

    it "routes to #show" do
      expect(:get => "/programs-by-day/2015-10-05").to route_to("program_days#show", :id => "2015-10-05")
    end

  end
end
