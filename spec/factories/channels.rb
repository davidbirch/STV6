# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  xmltv_id    :string(255)
#  free_or_pay :string(255)
#  name        :string(255)
#  short_name  :string(255)
#  black_flag  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :channel do
    xmltv_id "MyString"
free_or_pay "MyString"
name "MyString"
short_name "MyString"
black_flag false
  end

end
