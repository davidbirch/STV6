# == Schema Information
#
# Table name: migrators
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Migrator, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:migrator)).to be_valid
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryGirl.build(:migrator, requested_by: nil)).to_not be_valid
  end
  
  it "sets a default target_region_list" do
    @migrator = FactoryGirl.create(:migrator, target_region_list: nil)
    expect(@migrator.target_region_list).to eq('["Adelaide", "Brisbane", "Melbourne", "Perth", "Sydney"]')
  end
  
  it "sets a default requested_at" do
    @migrator = FactoryGirl.create(:migrator)
    expect(@migrator.requested_at).not_to be_nil
  end

  
end
