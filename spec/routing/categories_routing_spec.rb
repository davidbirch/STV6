# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categories").to route_to("categories#index")
    end

    it "routes to #new" do
      expect(:get => "/categories/new").to route_to("categories#new")
    end

    it "routes to #show" do
      expect(:get => "/categories/1").to route_to("categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/categories/1/edit").to route_to("categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/categories").to route_to("categories#create")
    end

    it "routes to #update" do
      expect(:put => "/categories/1").to route_to("categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/categories/1").to route_to("categories#destroy", :id => "1")
    end

    it "routes to #set_black_flag_on" do
      expect(:put => "/categories/1/set_black_flag_on").to route_to("categories#set_black_flag_on", :id => "1")
    end
    
    it "routes to #set_black_flag_off" do
      expect(:put => "/categories/1/set_black_flag_off").to route_to("categories#set_black_flag_off", :id => "1")
    end
  end
end
