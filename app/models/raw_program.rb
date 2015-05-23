class RawProgram < ActiveRecord::Base
  
  validates_presence_of :title
  validates_presence_of :region_name
  validates_presence_of :channel_xmltv_id
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  
  scope :historic, lambda {
      where("end_datetime < ?", Time.now)
  }  
  
end
