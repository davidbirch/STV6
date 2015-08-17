require "rails_helper"

RSpec.describe MigratorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/migrators").to route_to("migrators#index")
    end

    it "routes to #new" do
      expect(:get => "/migrators/new").to route_to("migrators#new")
    end

    it "routes to #show" do
      expect(:get => "/migrators/1").to route_to("migrators#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/migrators/1/edit").to route_to("migrators#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/migrators").to route_to("migrators#create")
    end

    it "routes to #update" do
      expect(:put => "/migrators/1").to route_to("migrators#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/migrators/1").to route_to("migrators#destroy", :id => "1")
    end

  end
end
