# == Schema Information
#
# Table name: raw_channels
#
#  id            :integer          not null, primary key
#  channel_hash  :text(65535)
#  channel_name  :string(255)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RawChannel < ActiveRecord::Base
  
  validates_presence_of :region_lookup
  validates_presence_of :region_name
  validates_presence_of :channel_name
  validates_presence_of :channel_tag
  
  class << self
    
    def create_from_channel_hash(region, channel_hash)
  
      attr_channel_hash = channel_hash
      attr_channel_name = channel_hash["name"]
      attr_channel_tag = channel_hash["channelTag"]
      attr_channel_images = channel_hash["channelImages"]
      
      # if nil then default to an empty string
      attr_channel_name ||= ""
      attr_channel_tag ||= ""
      attr_channel_images ||= ""
      
      if region
        RawChannel.create(
        :region_name          => region.name,
        :region_lookup        => region.region_lookup,
        :channel_hash         => attr_channel_hash,
        :channel_name         => attr_channel_name,
        :channel_tag          => attr_channel_tag,
        )          
      end  
    end
    
  end   

end
