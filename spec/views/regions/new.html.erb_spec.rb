require 'rails_helper'

RSpec.describe "regions/new", type: :view do
  before(:each) do
    assign(:region, Region.new(
      :name => "MyString",
      :timezone_adjustment => 1
    ))
  end

  it "renders new region form" do
    render

    assert_select "form[action=?][method=?]", regions_path, "post" do

      assert_select "input#region_name[name=?]", "region[name]"

      assert_select "input#region_timezone_adjustment[name=?]", "region[timezone_adjustment]"
    end
  end
end
