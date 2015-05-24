require 'rails_helper'

RSpec.describe "regions/edit", type: :view do
  before(:each) do
    @region = assign(:region, Region.create!(
      :name => "MyString",
      :timezone_adjustment => 1
    ))
  end

  it "renders the edit region form" do
    render

    assert_select "form[action=?][method=?]", region_path(@region), "post" do

      assert_select "input#region_name[name=?]", "region[name]"

      assert_select "input#region_timezone_adjustment[name=?]", "region[timezone_adjustment]"
    end
  end
end
