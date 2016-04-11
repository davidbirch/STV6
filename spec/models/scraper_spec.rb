# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  days_to_gather     :float(24)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
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
    expect(@scraper.days_to_gather).to eq(6)
  end
  
  it "sets a default target_region_list" do
    @scraper = FactoryGirl.create(:scraper, target_region_list: nil)
    expect(@scraper.target_region_list).to eq('[["Adelaide", "81"], ["Brisbane", "75"], ["Melbourne", "94"], ["Perth", "101"], ["Sydney", "73"]]')
  end
  
  it "sets a default requested_at" do
    @scraper = FactoryGirl.create(:scraper)
    expect(@scraper.requested_at).not_to be_nil
  end

  
end
