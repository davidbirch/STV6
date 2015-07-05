require "rails_helper"

RSpec.describe RawProgramsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-programs").to route_to("raw_programs#index")
    end

    it "routes to #new" do
      expect(:get => "/raw-programs/new").to route_to("raw_programs#new")
    end

    it "routes to #show" do
      expect(:get => "/raw-programs/1").to route_to("raw_programs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/raw-programs/1/edit").to route_to("raw_programs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/raw-programs").to route_to("raw_programs#create")
    end

    it "routes to #update" do
      expect(:put => "/raw-programs/1").to route_to("raw_programs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/raw-programs/1").to route_to("raw_programs#destroy", :id => "1")
    end

  end
end
