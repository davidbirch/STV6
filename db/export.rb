require "csv"

puts "#{Time.now.strftime("%F %T %Z")}: Started export"

broadcast_events = BroadcastEvent.includes(:program, :broadcast_service, :region, :channel, :keyword, :sport).order('programs.title', 'programs.episode_title')
entries = broadcast_events.pluck(
    :'programs.title',
    :'programs.episode_title', 
    :'sports.name', 
    :'sports.black_flag', 
    :'regions.black_flag', 
    :'channels.black_flag', 
    :'keywords.black_flag'
    ).uniq

puts "#{Time.now.strftime("%F %T %Z")}: >> Broadcast events  = #{broadcast_events.count}"
puts "#{Time.now.strftime("%F %T %Z")}: >> Unique broadcast events  = #{entries.count}"

return_array = Array.new
for entry in entries do
    new_entry = Array.new
    new_entry << entry[0] + " " + entry[1]
    if (entry[3] == 1 || entry[4] == 1 || entry[5] == 1 || entry[6] == 1)
      new_entry << "Non Sport"
    elsif entry[2] == "Non Sport"
      new_entry << "Non Sport"
    else
      new_entry << "Sport"
    end   
    new_entry << entry[2]
    return_array << new_entry
end
    
unique_return_array = return_array.uniq
puts "#{Time.now.strftime("%F %T %Z")}: >> Unique consolidated events  = #{unique_return_array.count}"

CSV.open("db/data/program_data.csv", "wb") do |csv|
  csv << ["Program Title", "Sport Flag", "Sport"]
  for export_summary in unique_return_array do
    #puts "The export event = #{export_summary}"
    csv << [export_summary[0], export_summary[1], export_summary[2]]
  end 

end

puts "#{Time.now.strftime("%F %T %Z")}: Completed export"
