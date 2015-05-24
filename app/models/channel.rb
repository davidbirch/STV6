# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  xmltv_id    :string(255)
#  free_or_pay :string(255)
#  name        :string(255)
#  short_name  :string(255)
#  black_flag  :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Channel < ActiveRecord::Base
end
