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
