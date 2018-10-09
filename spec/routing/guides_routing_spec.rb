# == Schema Information
#
#

require "rails_helper"

RSpec.describe GuidesController, type: :routing do
  describe "routing" do

    it "routes to #show for the region page" do
      expect(:get => "/region").to route_to("guides#show", :region_name => "region")
    end

    it "routes to #show for the region and sport page" do
      expect(:get => "/region/sport").to route_to("guides#show", :region_name => "region", :sport_name => "sport" )
    end

  end
end
