require 'rails_helper'

RSpec.describe "programs/index", type: :view do
  before(:each) do
    assign(:programs, [
      Program.create!(
        :title => "Title",
        :subtitle => "Subtitle",
        :category => "Category",
        :description => "Description",
        :region_id => 1,
        :channel_id => 2,
        :sport_id => 3
      ),
      Program.create!(
        :title => "Title",
        :subtitle => "Subtitle",
        :category => "Category",
        :description => "Description",
        :region_id => 1,
        :channel_id => 2,
        :sport_id => 3
      )
    ])
  end

  it "renders a list of programs" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
