# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  subtitle                 :string(255)
#  category                 :string(255)
#  url_friendly_category    :string(255)
#  description              :text(65535)
#  program_hash             :text(65535)
#  start_datetime           :datetime
#  end_datetime             :datetime
#  start_date_display       :string(255)
#  local_start_date_display :string(255)
#  region_id                :integer
#  channel_id               :integer
#  sport_id                 :integer
#  keyword_id               :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Program < ActiveRecord::Base
  
  belongs_to :channel
  belongs_to :region
  belongs_to :sport
  belongs_to :keyword
  
  validates_presence_of :title
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  validates_presence_of :region_id
  validates_presence_of :sport_id
  validates_presence_of :channel_id
  validates_presence_of :keyword_id
  
  validates_uniqueness_of :channel_id , :scope => [:region_id, :title, :sport_id, :start_datetime, :end_datetime]
  
  before_save :set_computed_columns
  
  scope :historic, ->{where("end_datetime < ?", Time.new(Time.now.year, Time.now.month, Time.now.day))}
  scope :exclude_black_channels, ->{where("channels.black_flag IS NULL OR channels.black_flag = false" )}
  scope :exclude_black_keywords, ->{where("keywords.black_flag IS NULL OR keywords.black_flag = false" )}
  scope :current, ->{where("end_datetime >= ?", Time.new(Time.now.year, Time.now.month, Time.now.day))}
  scope :chronological, ->{order("start_datetime ASC, end_datetime ASC")}
  scope :by_channel_short_name, ->{order("channels.short_name ASC, channels.name ASC")}
  scope :by_sport_name, ->{order("sports.name ASC")}
  scope :by_subtitle, ->{order("subtitle DESC, title DESC")}  
  scope :ordered_for_tv_guide, ->{includes(:sport, :channel, :region, :keyword).exclude_black_channels.exclude_black_keywords.current.chronological.by_sport_name.by_channel_short_name.by_subtitle}  
   
  def local_time_zone
    region.name
  end
   
  def local_start_datetime
    start_datetime.in_time_zone(local_time_zone)
  end
    
  def local_end_datetime
    end_datetime.in_time_zone(local_time_zone)
  end
    
  def current?
    end_datetime >= Time.now
  end
  
  def historic?
    end_datetime < Time.now
  end
    
  def full_title
    if subtitle != ""
      title + " (" + subtitle + ")"
    else
      title
    end
   end
    
  class << self
    
    def create_from_raw_program(raw_program)
      
      keyword = Keyword.find_for_raw_program(raw_program)
      sport = keyword.sport unless keyword.nil?
      region = Region.find_by_name(raw_program.region_name)
      channel = Channel.find_or_create_from_raw_program(raw_program)
        
      Program.create(
        :title          => raw_program.title,
        :subtitle       => raw_program.subtitle,
        :category       => raw_program.category,
        :description    => raw_program.description,
        :program_hash   => raw_program.program_hash,
        :start_datetime => raw_program.start_datetime,
        :end_datetime   => raw_program.end_datetime,
        :region_id      => (region.id unless region.nil?),
        :channel_id     => (channel.id unless channel.nil?),
        :sport_id       => (sport.id unless sport.nil?),
        :keyword_id     => (keyword.id unless keyword.nil?)
      )
    
    end
  
  end
  
  protected
  
    def set_computed_columns
        set_start_date_display
        set_local_start_date_display
        set_url_friendly_category
    end
            
    def set_start_date_display
      self.start_date_display = start_datetime.strftime("%F")
    end
    
    def set_local_start_date_display
      self.local_start_date_display = start_datetime.in_time_zone(region.name).strftime("%F")
    end
    
    def set_url_friendly_category
      self.url_friendly_category = category.parameterize
    end
    
end
