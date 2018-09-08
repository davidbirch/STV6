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

FactoryGirl.define do
  factory :scraper do
    target_region_list '["Adelaide","81"]'
    days_to_gather 5
    requested_by "Some User" 
  end

  factory :empty_region_scraper, parent: :scraper do |f|
    f.target_region_list ""
  end

end
