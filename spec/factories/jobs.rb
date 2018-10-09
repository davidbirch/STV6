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

FactoryBot.define do
  factory :job do
    requested_by { "Some User" }
    association :detail, factory: :scraper
    detail_type { "Scraper" }
  end

end
