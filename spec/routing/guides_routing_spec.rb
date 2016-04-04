require "rails_helper"

RSpec.describe GuidesController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/melbourne").to route_to("guides#show", :region_name => "melbourne")
    end

    it "routes to #show" do
      expect(:get => "/melbourne/cricket").to route_to("guides#show", :region_name => "melbourne", :sport_name => "cricket")
    end

    it "routes to #show" do
      expect(:get => "/melbourne?search=league").to route_to("guides#show", :region_name => "melbourne", :search => "league")
    end
    
    it "routes to #index" do
      expect(:get => "/").to route_to("guides#index")
    end
     
  end
end
