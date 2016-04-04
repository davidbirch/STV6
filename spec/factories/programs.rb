# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  subtitle                 :string(255)
#  description              :text(65535)
#  program_hash             :text(65535)
#  start_datetime           :datetime
#  end_datetime             :datetime
#  start_date_display       :string(255)
#  local_start_date_display :string(255)
#  region_id                :integer
#  channel_id               :integer
#  sport_id                 :integer
#  keyword_id               :integer
#  category_id              :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

FactoryGirl.define do
    
  factory :program do
    title "Some title"
    subtitle "Some subtitle"
    description "A show"
    program_hash "#A hash"
    start_datetime Time.new((Date.today + 1).year, (Date.today + 1).month, (Date.today + 1).day, 22, 00, 00)
    end_datetime Time.new((Date.today + 1).year, (Date.today + 1).month, (Date.today + 1).day, 23, 30, 00)
    region
    sport
    channel
    keyword
    category
  end
   
  factory :valid_program, parent: :program do |f|
    f.title "AFL Grand Final"
    f.subtitle "In September"
  end
  
  factory :invalid_program, parent: :program do |f|
    f.title ""
  end
   
  factory :historic_program, parent: :valid_program do |f|
    start_datetime Time.new((Date.today - 1).year, (Date.today - 1).month, (Date.today - 1).day, 22, 00, 00)
    end_datetime Time.new((Date.today - 1).year, (Date.today - 1).month, (Date.today - 1).day, 23, 30, 00)
  end

end
