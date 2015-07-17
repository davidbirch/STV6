require "rails_helper"

RSpec.describe ProgramCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs-by-category").to route_to("program_categories#index")
    end

    it "routes to #show" do
      expect(:get => "/programs-by-category/cricket").to route_to("program_categories#show", :id => "cricket")
    end

  end
end
