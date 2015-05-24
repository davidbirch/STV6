# == Schema Information
#
# Table name: regions
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  timezone_adjustment :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :region do
    name "MyString"
timezone_adjustment 1
  end

end
