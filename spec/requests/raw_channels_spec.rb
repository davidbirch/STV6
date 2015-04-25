require 'rails_helper'

RSpec.describe "RawChannels", type: :request do
  describe "GET /raw_channels" do
    it "works! (now write some real specs)" do
      get raw_channels_path
      expect(response).to have_http_status(200)
    end
  end
end
