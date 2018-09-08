# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  channel_hash            :text(65535)
#  name                    :string(255)
#  url_friendly_name       :string(255)
#  short_name              :string(255)
#  tag                     :string(255)
#  url_friendly_short_name :string(255)
#  default_sport           :string(255)
#  provider_id             :integer
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryGirl.define do
  factory :channel do
    name "ABC Hobart"
    short_name "ABC"
    tag "AHB"
    provider_id 1
  end
  
  factory :invalid_channel, parent: :channel do |f|
    f.name ""
  end
    
  factory :channel_seven, parent: :channel do |f|
    f.name "Seven"
    f.short_name "Sev"
    f.tag "SVN"
  end
  
  factory :channel_nine, parent: :channel do |f|
    f.name "Nine"
    f.short_name "Nine"
    f.tag "NIN"
  end
  
  factory :channel_gem, parent: :channel do |f|
    f.name "Gem"
    f.short_name "Nine"
    f.tag "GEM"
  end

end
