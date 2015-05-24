require 'rails_helper'

RSpec.describe "channels/index", type: :view do
  before(:each) do
    assign(:channels, [
      Channel.create!(
        :xmltv_id => "Xmltv",
        :free_or_pay => "Free Or Pay",
        :name => "Name",
        :short_name => "Short Name",
        :black_flag => false
      ),
      Channel.create!(
        :xmltv_id => "Xmltv",
        :free_or_pay => "Free Or Pay",
        :name => "Name",
        :short_name => "Short Name",
        :black_flag => false
      )
    ])
  end

  it "renders a list of channels" do
    render
    assert_select "tr>td", :text => "Xmltv".to_s, :count => 2
    assert_select "tr>td", :text => "Free Or Pay".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Short Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
