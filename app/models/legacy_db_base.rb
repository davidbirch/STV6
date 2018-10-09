class LegacyDbBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection LEGACY_DB  
end 

class LegacyRegion < LegacyDbBase 
  self.table_name = "regions"
end  

class LegacySport < LegacyDbBase 
  self.table_name = "sports"
end  

class LegacyProvider < LegacyDbBase 
  self.table_name = "providers"
end  

class LegacyChannel < LegacyDbBase 
  self.table_name = "channels"
  belongs_to :legacy_provider, foreign_key: 'provider_id'
end  

class LegacyKeyword < LegacyDbBase 
  self.table_name = "keywords"
  belongs_to :legacy_sport, foreign_key: 'sport_id'
end  

class LegacyProgram < LegacyDbBase 
  self.table_name = "programs"
  belongs_to :legacy_keyword, foreign_key: 'keyword_id'
end  

class LegacyBroadcastService < LegacyDbBase 
  self.table_name = "broadcast_services"
  belongs_to :legacy_region, foreign_key: 'region_id'
  belongs_to :legacy_channel, foreign_key: 'channel_id'
end  

class LegacyBroadcastEvent < LegacyDbBase 
  self.table_name = "broadcast_events"
  belongs_to :legacy_program, foreign_key: 'program_id'
  belongs_to :legacy_broadcast_service, foreign_key: 'broadcast_service_id'
end  