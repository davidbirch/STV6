# == Schema Information
#
# Table name: raw_programs
#
#  id            :integer          not null, primary key
#  program_hash  :text(65535)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  placeholder   :boolean
#  title         :string(255)
#  event_lookup  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :raw_program do
    channel_tag "TST"
    region_name "Hobart"
    region_lookup 12345
    placeholder false
  end
  
  factory :invalid_raw_program, parent: :raw_program do |f|
    f.channel_tag ""
  end
  
  factory :raw_program_including_hash, parent: :raw_program do |f|
    f.placeholder false
    f.channel_tag "NIA"
    f.region_name "Adelaide"
    f.region_lookup 20480
    f.program_hash  "{\"eventId\"=>86014439, \"programTitle\"=>\"Golf: The Players: 2008 Garcia\", \"scheduledDate\"=>1494455400000, \"duration\"=>300, \"episodeTitle\"=>\"2008 Garcia\", \"parentalRating\"=>\"NC\", \"premiereInd\"=>false, \"displaySepNum\"=>false, \"versionNum\"=>1280409, \"placeholder\"=>false, \"isMovie\"=>false, \"adultsOnly\"=>false}"
  end
  
  factory :duplicate_raw_program_1, parent: :raw_program do |f|
    f.placeholder false
    f.channel_tag "NIA"
    f.region_name "Adelaide"
    f.region_lookup 20480
    f.program_hash "{\"eventId\"=>85005195, \"programTitle\"=>\"FOX Sports News\", \"scheduledDate\"=>1494459000000, \"duration\"=>30, \"episodeTitle\"=>\"Episode 94\", \"parentalRating\"=>\"NC\", \"premiereInd\"=>false, \"displaySepNum\"=>false, \"versionNum\"=>1279177, \"placeholder\"=>false, \"isMovie\"=>false, \"adultsOnly\"=>false}"
  end
    
  factory :duplicate_raw_program_2, parent: :raw_program do |f|
    f.placeholder false
    f.channel_tag "TST"
    f.region_name "Hpbart"
    f.region_lookup 12345
    f.program_hash  "{\"eventId\"=>85989354, \"programTitle\"=>\"FOX Sports News\", \"scheduledDate\"=>1494460800000, \"duration\"=>30, \"episodeTitle\"=>\"Episode 94\", \"parentalRating\"=>\"NC\", \"premiereInd\"=>false, \"displaySepNum\"=>false, \"versionNum\"=>1279177, \"placeholder\"=>false, \"isMovie\"=>false, \"adultsOnly\"=>false}"
  end

end
