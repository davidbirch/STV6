# == Schema Information
#
# Table name: broadcast_services
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BroadcastService < ActiveRecord::Base
  
  belongs_to :region
  belongs_to :channel
  has_one :provider, through: :channel
  has_many :broadcast_events
  
  validates_presence_of :region_id
  validates_presence_of :channel_id
  
  validates_uniqueness_of :channel_id, :scope => [:region_id]

  def formatted_full_title
    channel.name + " (" + region.name + ")"
  end
  
class << self
    
    def create_from_raw_channel(raw_channel)
      region = Region.find_by_name(raw_channel.region_name)
      channel = Channel.find_by_tag(raw_channel.channel_tag)
      
      BroadcastService.create(
        :region_id    => (region.id unless region.nil?),
        :channel_id    => (channel.id unless channel.nil?),
      )
    end
    
  end

end
        