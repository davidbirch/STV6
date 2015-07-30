# == Schema Information
#
# Table name: raw_programs
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  subtitle         :string(255)
#  category         :string(255)
#  description      :string(255)
#  start_datetime   :datetime
#  end_datetime     :datetime
#  region_name      :string(255)
#  channel_xmltv_id :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class RawProgram < ActiveRecord::Base
  
end
