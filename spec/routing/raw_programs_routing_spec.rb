require "rails_helper"

RSpec.describe RawProgramsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-programs").to route_to("raw_programs#index")
    end

    it "routes to #show" do
      expect(:get => "/raw-programs/1").to route_to("raw_programs#show", :id => "1")
    end

  end
end
