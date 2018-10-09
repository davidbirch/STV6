# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  email      :string(255)
#  source     :text(65535)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user do
    provider { "MyString" }
    uid { "MyString" }
    name { "MyString" }
    email { "MyString" }
    admin { false }
  end
  
  factory :valid_user, parent: :user do |f|
    f.provider { "twitter" }
    f.uid { "123545" }
    f.name { "mockuser" }
    f.admin { false }
  end
  
  factory :valid_admin_user, parent: :user do |f|
    f.provider { "twitter" }
    f.uid { "123545" }
    f.name { "mockuser" }
    f.admin { true }
  end

end
