
require "csv"

CSV.open("db/data/regions.csv", "wb") do |csv|
  Region.all.each do |region|
    csv << [region.name, region.time_zone_name, region.region_lookup, region.black_flag]
  end
end

CSV.open("db/data/sports.csv", "wb") do |csv|
  Sport.all.each do |sport|
    csv << [sport.name, sport.black_flag]
  end
end

CSV.open("db/data/keywords.csv", "wb") do |csv|
  Keyword.all.each do |keyword|
    sport = keyword.sport
    csv << [keyword.value, sport.name, keyword.priority, keyword.black_flag]  
  end
end

CSV.open("db/data/providers.csv", "wb") do |csv|
  Provider.all.each do |provider|
    csv << [provider.name, provider.service_tier]
  end
end

CSV.open("db/data/channels.csv", "wb") do |csv|
  Channel.all.each do |channel|
    provider = channel.provider
    csv << [channel.name, channel.short_name, channel.tag, channel.black_flag, channel.default_sport, provider.name, channel.channel_hash]  
  end
end

CSV.open("db/data/broadcast_services.csv", "wb") do |csv|
  BroadcastService.all.each do |broadcast_service|
    region = broadcast_service.region
    channel = broadcast_service.channel
    csv << [region.name, channel.tag]  
  end
end