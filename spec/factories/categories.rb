# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :category do
    name "MyString"
  end
  
  factory :invalid_category, parent: :category do |f|
    f.name ""
  end

  factory :sport_category, parent: :category do |f|
    f.name "Sport"
    f.black_flag false
  end
  
  factory :movie_category, parent: :category do |f|
    f.name "Movie"
    f.black_flag true
  end
end
