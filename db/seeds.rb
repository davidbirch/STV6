# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

# import the data for regions
CSV.open("db/data/regions.csv", "r").each do |row|
  Region.find_or_create_by(name: row[0]) do |region|
    region.time_zone_name = row[1]
    region.region_lookup  = row[2]
    region.black_flag     = row[3]
  end 
end

# import the data for sports
CSV.open("db/data/sports.csv", "r").each do |row|
  Sport.find_or_create_by(name: row[0]) do |sport|
    sport.black_flag    = row[1]
  end
end

# import the data for keywords
CSV.open("db/data/keywords.csv", "r").each do |row|
  Keyword.find_or_create_by(value: row[0]) do |keyword|
    keyword.sport_id         = Sport.find_by(name: row[1]).id
    keyword.priority         = row[2]
    keyword.black_flag       = row[3]
  end
end

# import the data for sports
CSV.open("db/data/providers.csv", "r").each do |row|
  Provider.find_or_create_by(name: row[0]) do |provider|
    provider.service_tier       = row[1]
  end
end

# import the data for channels
CSV.open("db/data/channels.csv", "r").each do |row|
  Channel.find_or_create_by(tag: row[2]) do |channel|
    channel.name             = row[0]
    channel.short_name       = row[1]
    channel.black_flag       = row[3]
    channel.default_sport    = row[4]
    channel.provider_id      = Provider.find_by(name: row[5]).id
    channel.channel_hash     = row[6]
  end
end

# import the data for broadcast services
CSV.open("db/data/broadcast_services.csv", "r").each do |row|
  BroadcastService.find_or_create_by(region_id: Region.find_by(name: row[0]).id, channel_id: Channel.find_by(tag: row[1]).id)
end
