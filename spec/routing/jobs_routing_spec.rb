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

RSpec.describe JobsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cleaners").to route_to("cleaners#index")
    end

    it "routes to #show" do
      expect(:get => "/cleaners/1").to route_to("cleaners#show", :id => "1")
    end

  end
end
