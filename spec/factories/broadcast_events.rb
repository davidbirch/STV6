# == Schema Information
#
# Table name: broadcast_events
#
#  id                         :integer          not null, primary key
#  program_id                 :integer
#  broadcast_service_id       :integer
#  broadcast_event_hash       :text(65535)
#  epoch_scheduled_date       :integer
#  formatted_local_start_date :string(255)
#  formatted_scheduled_date   :datetime
#  formatted_end_date         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

FactoryGirl.define do
  factory :broadcast_event do
    program_id 1
    broadcast_service_id 2
    epoch_scheduled_date 1496455200
  end
  
  factory :invalid_broadcast_event, parent: :broadcast_event do |f|
    f.program_id nil
  end
    
  factory :broadcast_event_two, parent: :broadcast_event do |f|
    f.program_id 4
    f.broadcast_service_id 5
    f.epoch_scheduled_date 1496455300
  end
end
