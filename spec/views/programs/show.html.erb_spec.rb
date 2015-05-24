require 'rails_helper'

RSpec.describe "programs/show", type: :view do
  before(:each) do
    @program = assign(:program, Program.create!(
      :title => "Title",
      :subtitle => "Subtitle",
      :category => "Category",
      :description => "Description",
      :region_id => 1,
      :channel_id => 2,
      :sport_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
