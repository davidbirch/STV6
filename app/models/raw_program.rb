# == Schema Information
#
# Table name: raw_programs
#
#  id            :bigint(8)        not null, primary key
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

class RawProgram < ActiveRecord::Base
  
  validates_presence_of :region_lookup
  validates_presence_of :region_name
  validates_presence_of :channel_tag
  
  class << self
    
    def create_from_channel_event(region, channel_tag, channel_event)
      
      attr_placeholder = channel_event["placeholder"]
      attr_title = channel_event["programTitle"]
      attr_event_lookup = channel_event["eventId"]
      
      # if nil then default as follows
      attr_placeholder ||= false
      attr_title ||= ""
      attr_event_lookup ||= ""
      
      if region
        RawProgram.create(
        :region_name          => region.name,
        :region_lookup        => region.region_lookup,
        :program_hash         => channel_event,
        :channel_tag          => channel_tag,
        :placeholder          => attr_placeholder,
        :title                => attr_title,
        :event_lookup         => attr_event_lookup,
        )          
      end  
    end
    
  end   

end
