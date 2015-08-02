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
#  keyword_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  url_friendly_category :string(255)
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
  
  class << self
    
    def create_from_raw_program(raw_program)
      
      keyword = Keyword.find_for_raw_program(raw_program)
      sport = keyword.sport unless keyword.nil?
      region = Region.find_by_name(raw_program.region_name)
      channel = Channel.find_or_create_from_raw_program(raw_program)
          
      # bug where the time zone is not being set properly, calling an 'inspect' seems to fix it
      # may cause performance issues - however this is only used in the converter
      raw_program.inspect
      old_time_zone = Time.zone
      Time.zone = raw_program.region_name
        
      program = Program.create(
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
      Time.zone = old_time_zone
      return program
    
    end
  
  end
  
  protected
  
    def set_computed_columns
        set_start_date_display
        set_url_friendly_category
    end
    
    def set_start_date_display
      self.start_date_display = start_datetime.strftime("%F")
    end
    
    def set_url_friendly_category
      self.url_friendly_category = category.parameterize
    end
    
end
