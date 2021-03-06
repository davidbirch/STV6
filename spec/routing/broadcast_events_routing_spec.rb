# == Schema Information
#
# Table name: broadcast_events
#
#  id                         :integer          not null, primary key
#  program_id                 :integer
#  broadcast_service_id       :integer
#  broadcast_event_hash       :text(65535)
#  epoch_scheduled_date       :integer
#  formatted_local_start_date :string(255)
#  formatted_scheduled_date   :datetime
#  formatted_end_date         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require "rails_helper"

RSpec.describe BroadcastEventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/broadcast-events").to route_to("broadcast_events#index")
    end

    it "routes to #new" do
      expect(:get => "/broadcast-events/new").to route_to("broadcast_events#new")
    end

    it "routes to #show" do
      expect(:get => "/broadcast-events/1").to route_to("broadcast_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/broadcast-events/1/edit").to route_to("broadcast_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/broadcast-events").to route_to("broadcast_events#create")
    end

    it "routes to #update" do
      expect(:put => "/broadcast-events/1").to route_to("broadcast_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/broadcast-events/1").to route_to("broadcast_events#destroy", :id => "1")
    end

  end
end
