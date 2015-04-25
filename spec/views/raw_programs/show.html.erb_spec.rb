require 'rails_helper'

RSpec.describe "raw_programs/show", type: :view do
  before(:each) do
    @raw_program = assign(:raw_program, RawProgram.create!(
      :title => "Title",
      :subtitle => "Subtitle",
      :category => "Category",
      :description => "Description",
      :region_name => "Region Name",
      :channel_xmltv_id => "Channel Xmltv"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Region Name/)
    expect(rendered).to match(/Channel Xmltv/)
  end
end
