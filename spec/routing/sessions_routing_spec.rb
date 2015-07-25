require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/signin").to route_to("sessions#new")
    end

    it "routes to #destroy" do
      expect(:get => "/signout").to route_to("sessions#destroy")
    end
    
    it "routes to #failure" do
      expect(:get => "/auth/failure").to route_to("sessions#failure")
    end
    
    it "routes to #create" do
      expect(:get => "/auth/provider/callback").to route_to(
      :controller => "sessions",
      :action => "create",
      :provider => "provider"
    )
    end
     
  end
end
  