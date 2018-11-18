require "csv"

broadcast_events = BroadcastEvent.includes(:program, :broadcast_service, :region, :channel, :keyword, :sport)
export_summary = broadcast_events.pluck(
    :'programs.title',
    :'programs.episode_title', 
    :'sports.name', 
    :'sports.black_flag', 
    :'regions.black_flag', 
    :'channels.black_flag', 
    :'keywords.black_flag'
    ).uniq

CSV.open("db/data/broadcast_event_data.csv", "wb") do |csv|
  csv << ["Program Title", "Episode Title", "Sport Name", "Sport Flag", "Region Flag", "Channel Flag", "Keyword Flag"]
    export_summary.each do |export_event|
    csv << [export_event[0], export_event[1], export_event[2], export_event[3], export_event[4], export_event[5], export_event[6]]
  end
end


CSV.open("db/data/program_data.csv", "wb") do |csv|
  csv << ["Program Title", "Sport Flag", "Sport"]
  export_summary.each do |export_event|
    formatted_full_title = export_event[0] + " " + export_event[1]
    #puts "The export event = #{export_event}"
    # if any of the black flags are set then the sport should be set to 'Non Sport'
    if (export_event[3] == 1 || export_event[4] == 1 || export_event[5] == 1 || export_event[6] == 1)
      sport_flag = "Non Sport"
      sport_name = "Non Sport"
    else
      sport_name = export_event[2]
      if sport_name == "Non Sport"
        sport_flag = "Non Sport"
      else
        sport_flag = "Sport"
      end
    end
    csv << [formatted_full_title, sport_flag, sport_name]
  end
end
