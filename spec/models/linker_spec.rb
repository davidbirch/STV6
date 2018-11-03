# == Schema Information
#
# Table name: linkers
#
#  id           :bigint(8)        not null, primary key
#  requested_by :string(255)
#  job_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Linker, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.create(:linker)).to be_valid
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryBot.build(:linker, requested_by: nil)).to_not be_valid
  end
  
end
