require 'rails_helper'

RSpec.describe "raw_programs/new", type: :view do
  before(:each) do
    assign(:raw_program, RawProgram.new(
      :title => "MyString",
      :subtitle => "MyString",
      :category => "MyString",
      :description => "MyString",
      :region_name => "MyString",
      :channel_xmltv_id => "MyString"
    ))
  end

  it "renders new raw_program form" do
    render

    assert_select "form[action=?][method=?]", raw_programs_path, "post" do

      assert_select "input#raw_program_title[name=?]", "raw_program[title]"

      assert_select "input#raw_program_subtitle[name=?]", "raw_program[subtitle]"

      assert_select "input#raw_program_category[name=?]", "raw_program[category]"

      assert_select "input#raw_program_description[name=?]", "raw_program[description]"

      assert_select "input#raw_program_region_name[name=?]", "raw_program[region_name]"

      assert_select "input#raw_program_channel_xmltv_id[name=?]", "raw_program[channel_xmltv_id]"
    end
  end
end
