# == Schema Information
#
# Table name: programs
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  subtitle       :string(255)
#  category       :string(255)
#  description    :string(255)
#  start_datetime :datetime
#  end_datetime   :datetime
#  region_id      :integer
#  channel_id     :integer
#  sport_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :program do
    title "MyString"
subtitle "MyString"
category "MyString"
description "MyString"
start_datetime "2015-05-24 11:30:09"
end_datetime "2015-05-24 11:30:09"
region_id 1
channel_id 1
sport_id 1
  end

end
