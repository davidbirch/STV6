require "rails_helper"

RSpec.describe PagesController, type: :routing do
  describe "routing" do

    it "routes to #contact" do
      expect(:get => "/contact").to route_to("pages#contact")
    end

    it "routes to #privacy" do
      expect(:get => "/privacy").to route_to("pages#privacy")
    end

    it "routes to #dashboard" do
      expect(:get => "/dashboard").to route_to("pages#dashboard")
    end
    
    it "routes to #home" do
      expect(:get => "/").to route_to("guides#index")
    end
     
  end
end
