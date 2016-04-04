# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  url_friendly_value :string(255)
#  sport_id           :integer
#  priority           :integer
#  black_flag         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require "rails_helper"

RSpec.describe KeywordsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/keywords").to route_to("keywords#index")
    end

    it "routes to #new" do
      expect(:get => "/keywords/new").to route_to("keywords#new")
    end

    it "routes to #show" do
      expect(:get => "/keywords/1").to route_to("keywords#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/keywords/1/edit").to route_to("keywords#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/keywords").to route_to("keywords#create")
    end

    it "routes to #update" do
      expect(:put => "/keywords/1").to route_to("keywords#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/keywords/1").to route_to("keywords#destroy", :id => "1")
    end
    
    it "routes to #set_black_flag_on" do
      expect(:put => "/keywords/1/set_black_flag_on").to route_to("keywords#set_black_flag_on", :id => "1")
    end
    
    it "routes to #set_black_flag_off" do
      expect(:put => "/keywords/1/set_black_flag_off").to route_to("keywords#set_black_flag_off", :id => "1")
    end

  end
end
