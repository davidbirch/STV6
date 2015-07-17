require "rails_helper"

RSpec.describe RawProgramCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-programs-by-category").to route_to("raw_program_categories#index")
    end

  end
end
