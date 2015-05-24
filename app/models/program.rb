# == Schema Information
#
# Table name: programs
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  subtitle       :string(255)
#  category       :string(255)
#  description    :string(255)
#  start_datetime :datetime
#  end_datetime   :datetime
#  region_id      :integer
#  channel_id     :integer
#  sport_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Program < ActiveRecord::Base
end
