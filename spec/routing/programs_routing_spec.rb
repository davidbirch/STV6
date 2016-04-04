# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  subtitle                 :string(255)
#  description              :text(65535)
#  program_hash             :text(65535)
#  start_datetime           :datetime
#  end_datetime             :datetime
#  start_date_display       :string(255)
#  local_start_date_display :string(255)
#  region_id                :integer
#  channel_id               :integer
#  sport_id                 :integer
#  keyword_id               :integer
#  category_id              :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require "rails_helper"

RSpec.describe ProgramsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/programs").to route_to("programs#index")
    end

    it "routes to #new" do
      expect(:get => "/programs/new").to route_to("programs#new")
    end

    it "routes to #show" do
      expect(:get => "/programs/1").to route_to("programs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/programs/1/edit").to route_to("programs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/programs").to route_to("programs#create")
    end

    it "routes to #update" do
      expect(:put => "/programs/1").to route_to("programs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/programs/1").to route_to("programs#destroy", :id => "1")
    end

  end
end
