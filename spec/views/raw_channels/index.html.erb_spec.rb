require 'rails_helper'

RSpec.describe "raw_channels/index", type: :view do
  before(:each) do
    assign(:raw_channels, [
      RawChannel.create!(
        :xmltv_id => "Xmltv",
        :channel_name => "Channel Name"
      ),
      RawChannel.create!(
        :xmltv_id => "Xmltv",
        :channel_name => "Channel Name"
      )
    ])
  end

  it "renders a list of raw_channels" do
    render
    assert_select "tr>td", :text => "Xmltv".to_s, :count => 2
    assert_select "tr>td", :text => "Channel Name".to_s, :count => 2
  end
end
