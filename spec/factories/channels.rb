# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  free_or_pay             :string(255)
#  name                    :string(255)
#  short_name              :string(255)
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  url_friendly_name       :string(255)
#  url_friendly_short_name :string(255)
#

FactoryGirl.define do
  factory :channel do
    name "Test Channel"
    short_name "Test"
  end
  
  factory :invalid_channel, parent: :channel do |f|
    f.name ""
  end
    
  factory :channel_seven, parent: :channel do |f|
    f.name "Seven"
    f.short_name "Sev"
  end
  
  factory :channel_nine, parent: :channel do |f|
    f.name "Nine"
    f.short_name "Nine"
  end
  
  factory :channel_gem, parent: :channel do |f|
    f.name "Gem"
    f.short_name "Nine"
  end

end
