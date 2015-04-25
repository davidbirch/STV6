require 'rails_helper'

RSpec.describe "raw_channels/new", type: :view do
  before(:each) do
    assign(:raw_channel, RawChannel.new(
      :xmltv_id => "MyString",
      :channel_name => "MyString"
    ))
  end

  it "renders new raw_channel form" do
    render

    assert_select "form[action=?][method=?]", raw_channels_path, "post" do

      assert_select "input#raw_channel_xmltv_id[name=?]", "raw_channel[xmltv_id]"

      assert_select "input#raw_channel_channel_name[name=?]", "raw_channel[channel_name]"
    end
  end
end
