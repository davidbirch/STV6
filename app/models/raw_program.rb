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
  
end
