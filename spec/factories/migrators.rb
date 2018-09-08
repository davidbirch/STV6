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

FactoryGirl.define do
  factory :migrator do
    target_region_list '["Adelaide"]'
    requested_by "Some User" 
  end

  factory :empty_region_migrator, parent: :migrator do |f|
    f.target_region_list ""
  end
end
