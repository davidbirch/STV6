# == Schema Information
#
# Table name: broadcast_events
#
#  id                         :bigint(8)        not null, primary key
#  program_id                 :integer
#  broadcast_service_id       :integer
#  broadcast_event_hash       :text(65535)
#  epoch_scheduled_date       :bigint(8)
#  formatted_local_start_date :string(255)
#  formatted_scheduled_date   :datetime
#  formatted_end_date         :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class BroadcastEvent < ActiveRecord::Base
  
  belongs_to :program
  belongs_to :broadcast_service
  has_one :region, through: :broadcast_service
  has_one :channel, through: :broadcast_service
  has_one :keyword, through: :program
  has_one :sport, through: :keyword
  
  validates_presence_of :program_id
  validates_presence_of :broadcast_service_id
  validates_presence_of :epoch_scheduled_date
  
  validates_uniqueness_of :program_id, :scope => [:broadcast_service_id, :epoch_scheduled_date]

  before_save :set_computed_columns

  scope :historic, ->{where("formatted_end_date < ?", Time.new(Time.now.year, Time.now.month, Time.now.day))}
  scope :current, ->{where("formatted_end_date >= ?", Time.new(Time.now.year, Time.now.month, Time.now.day))}
  scope :chronological, ->{order("formatted_scheduled_date ASC, formatted_end_date ASC")}
  scope :by_channel_short_name, ->{joins(:channel).order("channels.short_name ASC, channels.name ASC")}
  scope :by_sport_name, ->{joins(:sport).order("sports.name ASC")}
  scope :by_title, ->{joins(:program).order("programs.episode_title DESC, programs.title DESC")}  
  scope :exclude_black_channels, ->{where("channels.black_flag IS NULL OR channels.black_flag = false" )}
  scope :exclude_black_keywords, ->{where("keywords.black_flag IS NULL OR keywords.black_flag = false" )}
  scope :exclude_black_sports, ->{where("sports.black_flag IS NULL OR sports.black_flag = false" )}
  scope :ordered_for_tv_guide, ->{current.chronological.by_sport_name.by_title.by_channel_short_name.exclude_black_keywords.exclude_black_channels.exclude_black_sports}  
   
  def current?
    formatted_end_date >= Time.zone.now
  end

  def on_now?
    formatted_end_date >= Time.zone.now && formatted_scheduled_date <= Time.zone.now
  end
  
  def historic?
    formatted_end_date < Time.zone.now
  end

  class << self
    
    def create_from_raw_program(raw_program, broadcast_service, program)
      
      if raw_program.placeholder?
        # do nothing  
      else
        if broadcast_service && program
          attr_program_hash = eval(raw_program.program_hash)
          attr_program_title = attr_program_hash["programTitle"]
          attr_episode_title = attr_program_hash["episodeTitle"]                  
          attr_duration = attr_program_hash["duration"]               
              
          # if nil then default to an empty string
          attr_program_title ||= ""
          attr_episode_title ||= ""
          attr_duration      ||= 0
              
          # program
          # program = Program.find_by(title: attr_program_title, episode_title: attr_episode_title, duration: attr_duration)
              
          attr_epoch_scheduled_date = attr_program_hash["scheduledDate"] / 1000
          # if nil then default to an empty string
          attr_epoch_scheduled_date ||= 0
                              
          BroadcastEvent.create(
            :broadcast_service_id     => (broadcast_service.id unless broadcast_service.nil?),
            :program_id               => (program.id unless program.nil?),
            :broadcast_event_hash     => attr_program_hash,
            :epoch_scheduled_date     => attr_epoch_scheduled_date,
          )  
        else
          # no broadcast service
      
        end          
      end
    end 
    
  end

  protected
  
  def set_computed_columns
    set_formatted_local_start_date
    set_formatted_scheduled_date
    set_formatted_end_date
  end
  
  def set_formatted_local_start_date
    self.formatted_local_start_date = Time.at(epoch_scheduled_date).in_time_zone(region.time_zone_name).strftime("%F")
  end

  def set_formatted_scheduled_date
    self.formatted_scheduled_date = Time.at(epoch_scheduled_date).in_time_zone(region.time_zone_name)
  end

  def set_formatted_end_date
    self.formatted_end_date = Time.at(epoch_scheduled_date).in_time_zone(region.time_zone_name) + program.duration.minutes
  end

end
        
