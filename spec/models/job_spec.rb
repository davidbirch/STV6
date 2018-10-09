# == Schema Information
#
# Table name: jobs
#
#  id           :bigint(8)        not null, primary key
#  log          :text(65535)
#  status       :string(255)
#  requested_by :string(255)
#  requested_at :datetime
#  started_at   :datetime
#  completed_at :datetime
#  detail_id    :integer
#  detail_type  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Job, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.create(:job)).to be_valid
  end
       
  it "is invalid without a detail_id" do
    expect(FactoryBot.build(:job, detail_id: nil)).to validate_presence_of(:detail_id)
  end
  
  it "is invalid without a detail_type" do
    expect(FactoryBot.build(:job, detail_type: nil)).to validate_presence_of(:detail_type)
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryBot.build(:job, requested_by: nil)).to validate_presence_of(:requested_by)
  end
  
  it "should belong to a detail" do
    expect(FactoryBot.build(:job)).to belong_to(:detail)
  end
  
end
