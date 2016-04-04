# == Schema Information
#
# Table name: raw_programs
#
#  id                  :integer          not null, primary key
#  program_hash        :text(65535)
#  title               :string(255)
#  subtitle            :string(255)
#  category            :string(255)
#  description         :text(65535)
#  start_datetime      :datetime
#  end_datetime        :datetime
#  region_name         :string(255)
#  channel_name        :string(255)
#  channel_free_or_pay :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
      
  factory :raw_program do
    title "Some title"
    subtitle "Some subtitle"
    category "The category"
    description "A show"
    start_datetime Time.new((Date.today + 1).year, (Date.today + 1).month, (Date.today + 1).day, 22, 00, 00)
    end_datetime Time.new((Date.today + 1).year, (Date.today + 1).month, (Date.today + 1).day, 23, 30, 00)
    region_name "Some region"
    channel_name "Channel"   
  end
  
  factory :valid_raw_program, parent: :raw_program do |f|
    f.region_name "Brisbane"
    f.channel_name "Seven"   
  end
  
  factory :invalid_raw_program, parent: :raw_program do |f|
    f.region_name ""
  end
  
  factory :tennis_raw_program, parent: :valid_raw_program do |f|
    f.category "Tennis"  
  end
  
  factory :cricket_raw_program, parent: :valid_raw_program do |f|
    f.category "Cricket"  
  end
  
  factory :rugby_league_raw_program, parent: :valid_raw_program do |f|
    f.category "Rugby League"  
  end
  
  factory :other_sport_raw_program, parent: :valid_raw_program do |f|
    f.category "Sport"  
  end
  
  factory :news_raw_program, parent: :valid_raw_program do |f|
    f.category "Sport/News"  
  end
  
  factory :non_sport_raw_program, parent: :valid_raw_program do |f|
    f.category "Movie"  
  end
  
  factory :terminator_keyword_raw_program, parent: :valid_raw_program do |f|
    f.category "Cricket"
    f.title "Terminator"
  end
  
  factory :historic_raw_program, parent: :valid_raw_program do |f|
    f.start_datetime Time.new((Date.today - 1).year, (Date.today - 1).month, (Date.today - 1).day, 22, 00, 00)
    f.end_datetime Time.new((Date.today - 1).year, (Date.today - 1).month, (Date.today - 1).day, 23, 30, 00)
  end
    
end
