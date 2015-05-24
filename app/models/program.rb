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
  
  belongs_to :channel
  belongs_to :region
  belongs_to :sport
  
  validates_presence_of :title
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  validates_presence_of :region_id
  validates_presence_of :sport_id
  validates_presence_of :channel_id
  
  validates_uniqueness_of :channel_id , :scope => [:region_id, :title, :sport_id, :start_datetime, :end_datetime]
  
end
