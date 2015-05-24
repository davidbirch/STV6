require 'rails_helper'

RSpec.describe "channels/show", type: :view do
  before(:each) do
    @channel = assign(:channel, Channel.create!(
      :xmltv_id => "Xmltv",
      :free_or_pay => "Free Or Pay",
      :name => "Name",
      :short_name => "Short Name",
      :black_flag => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Xmltv/)
    expect(rendered).to match(/Free Or Pay/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Short Name/)
    expect(rendered).to match(/false/)
  end
end
