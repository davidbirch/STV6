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
  Region.find_or_create_by(name: row[0]) do |r|
    r.timezone_adjustment = row[1]
  end
end

# import the data for sports
CSV.open("db/data/sports.csv", "r").each do |row|
  sport = Sport.find_or_create_by(name: row[0])
  Keyword.find_or_create_by(value: row[0]) do |k|
      k.sport_id = sport.id
      if row[0] == "Other Sport"
		k.priority = 0
      else      
        k.priority = 20
      end
    end
end

# import the data for channels
#CSV.open("db/data/channels.csv", "r").each do |row|
#  Channel.find_or_create_by(name: row[0]) do |c|
#    c.short_name = row[1]
#    c.xmltv_id = row[2]
#    c.black_flag = row[3]
#  end
#end

# import the data for keywords
CSV.open("db/data/keywords.csv", "r").each do |row|
  Keyword.find_or_create_by(value: row[0]) do |k|
    k.sport_id = Sport.find_by(name: row[1]).id
    k.priority = row[2]
  end
end

