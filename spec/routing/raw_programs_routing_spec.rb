# == Schema Information
#
# Table name: raw_programs
#
#  id                  :integer          not null, primary key
#  program_hash        :text(65535)
#  title               :string(255)
#  subtitle            :string(255)
#  category            :string(255)
#  description         :text(65535)
#  start_datetime      :datetime
#  end_datetime        :datetime
#  region_name         :string(255)
#  channel_name        :string(255)
#  channel_free_or_pay :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require "rails_helper"

RSpec.describe RawProgramsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw-programs").to route_to("raw_programs#index")
    end

    it "routes to #show" do
      expect(:get => "/raw-programs/1").to route_to("raw_programs#show", :id => "1")
    end

  end
end
