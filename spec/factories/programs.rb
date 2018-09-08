# == Schema Information
#
# Table name: programs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  episode_title :string(255)
#  keyword_id    :integer
#  duration      :integer
#  black_flag    :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :program do
    title "Test Program"
    duration 30
    keyword_id 1
  end
  
  factory :invalid_program, parent: :program do |f|
    f.title ""
  end

  factory :another_program, parent: :program do |f|
    f.title "Another Program"
    f.episode_title "Episode 2"
  end

end
