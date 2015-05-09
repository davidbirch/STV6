class RawChannel < ActiveRecord::Base
  
  validates_presence_of :xmltv_id
  validates_presence_of :channel_name
  
  validates_uniqueness_of :xmltv_id
  validates_uniqueness_of :channel_name  
  
end
