require 'rails_helper'

RSpec.describe "raw_programs/index", type: :view do
  before(:each) do
    assign(:raw_programs, [
      RawProgram.create!(
        :title => "Title",
        :subtitle => "Subtitle",
        :category => "Category",
        :description => "Description",
        :region_name => "Region Name",
        :channel_xmltv_id => "Channel Xmltv"
      ),
      RawProgram.create!(
        :title => "Title",
        :subtitle => "Subtitle",
        :category => "Category",
        :description => "Description",
        :region_name => "Region Name",
        :channel_xmltv_id => "Channel Xmltv"
      )
    ])
  end

  it "renders a list of raw_programs" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Region Name".to_s, :count => 2
    assert_select "tr>td", :text => "Channel Xmltv".to_s, :count => 2
  end
end
