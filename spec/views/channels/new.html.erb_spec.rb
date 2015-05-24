require 'rails_helper'

RSpec.describe "channels/new", type: :view do
  before(:each) do
    assign(:channel, Channel.new(
      :xmltv_id => "MyString",
      :free_or_pay => "MyString",
      :name => "MyString",
      :short_name => "MyString",
      :black_flag => false
    ))
  end

  it "renders new channel form" do
    render

    assert_select "form[action=?][method=?]", channels_path, "post" do

      assert_select "input#channel_xmltv_id[name=?]", "channel[xmltv_id]"

      assert_select "input#channel_free_or_pay[name=?]", "channel[free_or_pay]"

      assert_select "input#channel_name[name=?]", "channel[name]"

      assert_select "input#channel_short_name[name=?]", "channel[short_name]"

      assert_select "input#channel_black_flag[name=?]", "channel[black_flag]"
    end
  end
end
