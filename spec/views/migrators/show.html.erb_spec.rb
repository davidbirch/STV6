require 'rails_helper'

RSpec.describe "migrators/show", type: :view do
  before(:each) do
    @migrator = assign(:migrator, Migrator.create!(
      :target_region_list => "MyText",
      :log => "MyText",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status/)
  end
end
