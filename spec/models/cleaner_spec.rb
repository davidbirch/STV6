# == Schema Information
#
# Table name: cleaners
#
#  id                              :integer          not null, primary key
#  requested_by                    :string(255)
#  clean_raw_programs              :boolean
#  clean_raw_channels              :boolean
#  clean_broadcast_events          :boolean
#  clean_historic_broadcast_events :boolean
#  clean_programs                  :boolean
#  clean_broadcast_services        :boolean
#  clean_channels                  :boolean
#  job_id                          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#

require 'rails_helper'

RSpec.describe Cleaner, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:cleaner)).to be_valid
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryGirl.build(:cleaner, requested_by: nil)).to_not be_valid
  end
  
end
