# == Schema Information
#
# Table name: broadcast_services
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe BroadcastServicesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/broadcast-services").to route_to("broadcast_services#index")
    end

    it "routes to #new" do
      expect(:get => "/broadcast-services/new").to route_to("broadcast_services#new")
    end

    it "routes to #show" do
      expect(:get => "/broadcast-services/1").to route_to("broadcast_services#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/broadcast-services/1/edit").to route_to("broadcast_services#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/broadcast-services").to route_to("broadcast_services#create")
    end

    it "routes to #update" do
      expect(:put => "/broadcast-services/1").to route_to("broadcast_services#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/broadcast-services/1").to route_to("broadcast_services#destroy", :id => "1")
    end

  end
end
