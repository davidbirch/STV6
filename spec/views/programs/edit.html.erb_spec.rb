require 'rails_helper'

RSpec.describe "programs/edit", type: :view do
  before(:each) do
    @program = assign(:program, Program.create!(
      :title => "MyString",
      :subtitle => "MyString",
      :category => "MyString",
      :description => "MyString",
      :region_id => 1,
      :channel_id => 1,
      :sport_id => 1
    ))
  end

  it "renders the edit program form" do
    render

    assert_select "form[action=?][method=?]", program_path(@program), "post" do

      assert_select "input#program_title[name=?]", "program[title]"

      assert_select "input#program_subtitle[name=?]", "program[subtitle]"

      assert_select "input#program_category[name=?]", "program[category]"

      assert_select "input#program_description[name=?]", "program[description]"

      assert_select "input#program_region_id[name=?]", "program[region_id]"

      assert_select "input#program_channel_id[name=?]", "program[channel_id]"

      assert_select "input#program_sport_id[name=?]", "program[sport_id]"
    end
  end
end
