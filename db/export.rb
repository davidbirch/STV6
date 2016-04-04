
require "csv"

CSV.open("db/data/categories.csv", "wb") do |csv|
  Category.all.each do |category|
    csv << [category.name, category.black_flag]
  end
end

CSV.open("db/data/channels.csv", "wb") do |csv|
  Channel.all.each do |channel|
    csv << [channel.name, channel.short_name, channel.black_flag]
  end
end

CSV.open("db/data/regions.csv", "wb") do |csv|
  Region.all.each do |region|
    csv << [region.name]
  end
end

CSV.open("db/data/sports.csv", "wb") do |csv|
  Sport.all.each do |sport|
    csv << [sport.name]
  end
end

CSV.open("db/data/keywords.csv", "wb") do |csv|
  Keyword.all.each do |keyword|
    sport = keyword.sport
    csv << [keyword.value, sport.name, keyword.priority]  
  end
end