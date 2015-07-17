# == Schema Information
#
# Table name: programs
#
#  id                    :integer          not null, primary key
#  title                 :string(255)
#  subtitle              :string(255)
#  category              :string(255)
#  description           :string(255)
#  start_datetime        :datetime
#  start_date_display    :string(255)
#  end_datetime          :datetime
#  region_id             :integer
#  channel_id            :integer
#  sport_id              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  url_friendly_category :string(255)
#

FactoryGirl.define do
  
  TEN_PM_TOMORROW_PROG ||= DateTime.new((DateTime.now + 1).year, (DateTime.now + 1).month, (DateTime.now + 1).day, 8, 0, 0, '+10')
  ELEVEN_PM_TOMORROW_PROG ||= DateTime.new((DateTime.now + 1).year, (DateTime.now + 1).month, (DateTime.now + 1).day, 9, 0, 0, '+10')
  TEN_PM_YESTERDAY_PROG ||= DateTime.new((DateTime.now - 1).year, (DateTime.now - 1).month, (DateTime.now - 1).day, 8, 0, 0, '+10')
  ELEVEN_PM_YESTERDAY_PROG ||= DateTime.new((DateTime.now - 1).year, (DateTime.now - 1).month, (DateTime.now - 1).day, 9, 0, 0, '+10')
  
  TEN_PM_TOMORROW_UTC_PROG ||= DateTime.new((DateTime.now + 1).year, (DateTime.now + 1).month, (DateTime.now + 1).day, 8, 0, 0)
  ELEVEN_PM_TOMORROW_UTC_PROG ||= DateTime.new((DateTime.now + 1).year, (DateTime.now + 1).month, (DateTime.now + 1).day, 9, 0, 0)
  TEN_PM_YESTERDAY_UTC_PROG ||= DateTime.new((DateTime.now - 1).year, (DateTime.now - 1).month, (DateTime.now - 1).day, 8, 0, 0)
  ELEVEN_PM_YESTERDAY_UTC_PROG ||= DateTime.new((DateTime.now - 1).year, (DateTime.now - 1).month, (DateTime.now - 1).day, 9, 0, 0)
  
  
  factory :program do
    title "Some title"
    subtitle "Some subtitle"
    category "The category"
    description "A show"
    start_datetime TEN_PM_TOMORROW_UTC_PROG
    end_datetime TEN_PM_TOMORROW_UTC_PROG
    region
    sport
    channel
  end
   
  factory :valid_program, parent: :program do |f|
    f.title "AFL Grand Final"
    f.subtitle "In September"
    f.category "Sport/AFL"
  end
  
  factory :invalid_program, parent: :program do |f|
    f.title ""
  end
   
  factory :historic_program, parent: :valid_program do |f|
    f.start_datetime TEN_PM_YESTERDAY_UTC_PROG
    f.end_datetime ELEVEN_PM_YESTERDAY_UTC_PROG
  end

end
