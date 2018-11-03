# == Schema Information
#
# Table name: linkers
#
#  id           :bigint(8)        not null, primary key
#  requested_by :string(255)
#  job_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :linker do
    requested_by { "Some User" } 
  end
  
  factory :empty_requested_linker, parent: :linker do |f|
    f.requested_by { "" }
  end

end
