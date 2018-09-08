# == Schema Information
#
# Table name: migrators
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  requested_by       :string(255)
#  job_id             :integer
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
    @region = FactoryGirl.create(:region_melbourne)
    @migrator = FactoryGirl.create(:migrator, target_region_list: nil)
    expect(@migrator.target_region_list).to eq(Region.pluck(:name).to_s)
  end
  
end
