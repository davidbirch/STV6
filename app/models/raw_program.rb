# == Schema Information
#
# Table name: raw_programs
#
#  id                  :integer          not null, primary key
#  program_hash        :text(65535)
#  title               :string(255)
#  subtitle            :string(255)
#  category            :string(255)
#  description         :text(65535)
#  start_datetime      :datetime
#  end_datetime        :datetime
#  region_name         :string(255)
#  channel_name        :string(255)
#  channel_free_or_pay :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class RawProgram < ActiveRecord::Base
  
  validates_presence_of :title
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  validates_presence_of :region_name
  validates_presence_of :channel_name
  
  def self.create_raw_program_from_data_hash(region_name, tv)
    attr_program_hash = tv
    attr_title = tv["title"][0]["0"] unless tv["title"].nil?
    attr_subtitle = tv["subtitle"][0]["0"] unless tv["subtitle"].nil?
    attr_category = tv["category"][0]["item"][0]["0"]
    attr_description = tv["description_1"]
    if tv["co_v_short"]
      if tv["co_v_short"].class == Array
        attr_channel_name = tv["co_v_short"][0]["0"]
        attr_channel_free_or_pay = "pay"
      else
        attr_channel_name = tv["co_v_short"]
        attr_channel_free_or_pay = "free"
      end   
    end
    attr_start_datetime = Time.at(tv["event_date"][0]["0"].to_i) unless tv["event_date"][0]["0"].nil?
    attr_end_datetime = Time.at(tv["end_date"][0]["0"].to_i) unless tv["end_date"][0]["0"].nil?
    
    # if nil then default to an empty string
    attr_title ||= ""
    attr_subtitle ||= ""
    attr_category ||= ""
    attr_description ||= ""
    
    RawProgram.create(
      :region_name          => region_name,
      :program_hash         => attr_program_hash,
      :title                => attr_title,
      :subtitle             => attr_subtitle,
      :category             => attr_category,
      :description          => attr_description,
      :channel_name         => attr_channel_name,
      :channel_free_or_pay  => attr_channel_free_or_pay,
      :start_datetime       => attr_start_datetime,
      :end_datetime         => attr_end_datetime,
      )
  end
  
  def self.migrate_all_to_programs
    programs_skipped = 0
    programs_created = 0
    
    RawProgram.find_each do |raw_program|
      program = Program.create_from_raw_program(raw_program)
      if program.new_record?
        programs_skipped += 1
      else
        programs_created += 1
      end
    end
  end
  
end
