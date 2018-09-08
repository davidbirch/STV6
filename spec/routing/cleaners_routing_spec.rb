# == Schema Information
#
# Table name: cleaners
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require "rails_helper"

RSpec.describe CleanersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cleaners").to route_to("cleaners#index")
    end

    it "routes to #new" do
      expect(:get => "/cleaners/new").to route_to("cleaners#new")
    end

    it "routes to #show" do
      expect(:get => "/cleaners/1").to route_to("cleaners#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cleaners/1/edit").to route_to("cleaners#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cleaners").to route_to("cleaners#create")
    end

    it "routes to #update" do
      expect(:put => "/cleaners/1").to route_to("cleaners#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cleaners/1").to route_to("cleaners#destroy", :id => "1")
    end

  end
end
