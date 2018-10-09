# == Schema Information
#
# Table name: migrators
#
#  id                 :bigint(8)        not null, primary key
#  target_region_list :text(65535)
#  requested_by       :string(255)
#  job_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Migrator, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.create(:migrator)).to be_valid
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryBot.build(:migrator, requested_by: nil)).to_not be_valid
  end
      
  it "sets a default target_region_list" do
    @region = FactoryBot.create(:region_melbourne)
    @migrator = FactoryBot.create(:migrator, target_region_list: nil)
    expect(@migrator.target_region_list).to eq(Region.pluck(:name).to_s)
  end
  
end
