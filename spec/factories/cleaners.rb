# == Schema Information
#
# Table name: cleaners
#
#  id                              :integer          not null, primary key
#  requested_by                    :string(255)
#  clean_raw_programs              :boolean
#  clean_raw_channels              :boolean
#  clean_broadcast_events          :boolean
#  clean_historic_broadcast_events :boolean
#  clean_programs                  :boolean
#  clean_broadcast_services        :boolean
#  clean_channels                  :boolean
#  job_id                          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#

FactoryGirl.define do
  factory :cleaner do
    requested_by "Some User" 
  end
  
  factory :empty_requested_cleaner, parent: :cleaner do |f|
    f.requested_by "" 
  end

end
