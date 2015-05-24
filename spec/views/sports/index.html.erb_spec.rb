require 'rails_helper'

RSpec.describe "sports/index", type: :view do
  before(:each) do
    assign(:sports, [
      Sport.create!(
        :name => "Name"
      ),
      Sport.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of sports" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
