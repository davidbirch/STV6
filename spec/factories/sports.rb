# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :sport do
    name "MyString"
  end

end
