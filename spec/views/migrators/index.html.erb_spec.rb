require 'rails_helper'

RSpec.describe "migrators/index", type: :view do
  before(:each) do
    assign(:migrators, [
      Migrator.create!(
        :target_region_list => "MyText",
        :log => "MyText",
        :status => "Status"
      ),
      Migrator.create!(
        :target_region_list => "MyText",
        :log => "MyText",
        :status => "Status"
      )
    ])
  end

  it "renders a list of migrators" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
