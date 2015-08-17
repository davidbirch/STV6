require 'rails_helper'

RSpec.describe "migrators/new", type: :view do
  before(:each) do
    assign(:migrator, Migrator.new(
      :target_region_list => "MyText",
      :log => "MyText",
      :status => "MyString"
    ))
  end

  it "renders new migrator form" do
    render

    assert_select "form[action=?][method=?]", migrators_path, "post" do

      assert_select "textarea#migrator_target_region_list[name=?]", "migrator[target_region_list]"

      assert_select "textarea#migrator_log[name=?]", "migrator[log]"

      assert_select "input#migrator_status[name=?]", "migrator[status]"
    end
  end
end
