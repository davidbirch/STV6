# == Schema Information
#
# Table name: linkers
#
#  id                              :bigint(8)        not null, primary key
#  requested_by                    :string(255)
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#

require "rails_helper"

RSpec.describe LinkersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/linkers").to route_to("linkers#index")
    end

    it "routes to #new" do
      expect(:get => "/linkers/new").to route_to("linkers#new")
    end

    it "routes to #show" do
      expect(:get => "/linkers/1").to route_to("linkers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/linkers/1/edit").to route_to("linkers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/linkers").to route_to("linkers#create")
    end

    it "routes to #update" do
      expect(:put => "/linkers/1").to route_to("linkers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/linkers/1").to route_to("linkers#destroy", :id => "1")
    end

  end
end
