require "rails_helper"

RSpec.describe ConversionSummariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/conversion_summaries").to route_to("conversion_summaries#index")
    end

    it "routes to #show" do
      expect(:get => "/conversion_summaries/1").to route_to("conversion_summaries#show", :id => "1")
    end

  end
end
