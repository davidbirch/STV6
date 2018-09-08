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

class Channel < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  belongs_to :provider
  has_many :broadcast_services
  has_many :regions, through: :broadcast_services
  has_many :broadcast_events, through: :broadcast_services
  
  validates_presence_of :name
  validates_presence_of :tag
  validates_presence_of :short_name
  validates_presence_of :provider_id
  
  validates_uniqueness_of :tag
    
  before_save :set_computed_columns
  
  class << self
    
    def create_from_raw_channel(raw_channel)
      region = Region.find_by_name(raw_channel.region_name)
      provider = Provider.first
      
      Channel.save_image_files_from_channel_hash(eval(raw_channel.channel_hash))
      
      Channel.create(
        :name           => raw_channel.channel_name,
        :short_name     => raw_channel.channel_name[0,4],
        :tag            => raw_channel.channel_tag,
        :provider_id    => (provider.id unless provider.nil?),
        :channel_hash   => raw_channel.channel_hash,
        
      )

    end
    
    def save_image_files_from_channel_hash(channel_hash)
      require 'open-uri'
      channel_hash["channelImages"].each do |key, value|
          uri = URI.parse(value)
          target = "public/images/channels/"+File.basename(uri.path)
          unless FileTest.exist?(target)
            open(value) {|f|
              File.open(target,"wb") do |file|
                file.puts f.read
              end
            }
          end
      end     
    end 
      
  end
  
  protected
  
  def set_computed_columns
      set_url_friendly_name
      set_url_friendly_short_name
  end
    
  def set_url_friendly_name
      self.url_friendly_name = (name+" "+tag).parameterize
  end 
    
  def set_url_friendly_short_name
    self.url_friendly_short_name = short_name.parameterize
  end

end
