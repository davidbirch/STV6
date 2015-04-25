require 'rails_helper'

RSpec.describe "raw_channels/edit", type: :view do
  before(:each) do
    @raw_channel = assign(:raw_channel, RawChannel.create!(
      :xmltv_id => "MyString",
      :channel_name => "MyString"
    ))
  end

  it "renders the edit raw_channel form" do
    render

    assert_select "form[action=?][method=?]", raw_channel_path(@raw_channel), "post" do

      assert_select "input#raw_channel_xmltv_id[name=?]", "raw_channel[xmltv_id]"

      assert_select "input#raw_channel_channel_name[name=?]", "raw_channel[channel_name]"
    end
  end
end
