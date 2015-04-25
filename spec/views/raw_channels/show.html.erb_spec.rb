require 'rails_helper'

RSpec.describe "raw_channels/show", type: :view do
  before(:each) do
    @raw_channel = assign(:raw_channel, RawChannel.create!(
      :xmltv_id => "Xmltv",
      :channel_name => "Channel Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Xmltv/)
    expect(rendered).to match(/Channel Name/)
  end
end
