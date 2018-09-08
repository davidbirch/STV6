# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
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

FactoryGirl.define do
  factory :job do
    requested_by "Some User"
    detail_id 1
    detail_type "Scraper"
  end

end
