# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  days_to_gather     :float(24)
#  requested_by       :string(255)
#  job_id             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Scraper, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:scraper)).to be_valid
  end
  
  it "is invalid without a requested_by" do
    expect(FactoryGirl.build(:scraper, requested_by: nil)).to_not be_valid
  end
     
  it "sets a default days_to_gather" do
    @scraper = FactoryGirl.create(:scraper, days_to_gather: nil)
    expect(@scraper.days_to_gather).to eq(0.125)
  end
  
  it "sets a default target_region_list" do
    @region = FactoryGirl.create(:region_melbourne)
    @scraper = FactoryGirl.create(:scraper, target_region_list: nil)
    expect(@scraper.target_region_list).to eq(Region.pluck(:name, :region_lookup).to_s)
  end
    
end
