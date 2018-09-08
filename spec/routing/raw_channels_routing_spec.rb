# == Schema Information
#
# Table name: raw_programs
#
#  id            :integer          not null, primary key
#  program_hash  :text(65535)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "rails_helper"

RSpec.describe RawChannelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-channels").to route_to("raw_channels#index")
    end

    it "routes to #show" do
      expect(:get => "/raw-channels/1").to route_to("raw_channels#show", :id => "1")
    end

  end
end
