# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  url_friendly_name       :string(255)
#  short_name              :string(255)
#  url_friendly_short_name :string(255)
#  region_id               :integer
#  provider_id             :integer
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require "rails_helper"

RSpec.describe ChannelShortNamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/channels-by-short-name").to route_to("channel_short_names#index")
    end

    it "routes to #show" do
      expect(:get => "/channels-by-short-name/fox1").to route_to("channel_short_names#show", :id => "fox1")
    end

  end
end
