require 'rails_helper'

RSpec.describe "raw_channels/index", type: :view do
  before(:each) do
    assign(:raw_channels, [
      RawChannel.create!(
        :xmltv_id => "Xmltv1",
        :channel_name => "Channel Name 1"
      ),
      RawChannel.create!(
        :xmltv_id => "Xmltv2",
        :channel_name => "Channel Name 2"
      )
    ])
  end

  it "renders a list of raw_channels" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    expect(response.body).to include("Listing Raw Channels")
  end
end
