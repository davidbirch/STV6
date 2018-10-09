
# import the data for regions
puts "[---- Starting Load of Legacy Data ----]"
puts LegacyDbBase.name

legacy_regions = LegacyRegion.all
puts "Processing #{legacy_regions.count} regions"
legacy_regions.each do |legacy_region| 
    #puts "Creating new region for #{legacy_region.name}"
    Region.create(
        name:               legacy_region.name,
        time_zone_name:     legacy_region.time_zone_name,
        region_lookup:      legacy_region.region_lookup,
        black_flag:         legacy_region.black_flag,
        created_at:         legacy_region.created_at,
    )
end

legacy_sports = LegacySport.all
puts "Processing #{legacy_sports.count} sports"
legacy_sports.each do |legacy_sport| 
    #puts "Creating new sport for #{legacy_sport.name}"
    Sport.create(
        name:           legacy_sport.name,
        black_flag:     legacy_sport.black_flag,
        created_at:     legacy_sport.created_at,
    )
end

legacy_providers = LegacyProvider.all
puts "Processing #{legacy_providers.count} providers"
legacy_providers.each do |legacy_provider| 
    #puts "Creating new provider for #{legacy_provider.name}"
    Provider.create(
        name:           legacy_provider.name,
        service_tier:   legacy_provider.service_tier,
        created_at:     legacy_provider.created_at,
    )
end

legacy_channels = LegacyChannel.all
puts "Processing #{legacy_channels.count} channels"
legacy_channels.each do |legacy_channel| 
    #puts "Creating new channel for #{legacy_channel.name}"
    provider = Provider.where(name: legacy_channel.legacy_provider.name).first
    Channel.create(
        name:           legacy_channel.name,
        channel_hash:   legacy_channel.channel_hash,
        short_name:     legacy_channel.short_name,
        tag:            legacy_channel.tag,
        default_sport:  legacy_channel.default_sport,
        black_flag:     legacy_channel.black_flag,
        provider_id:    provider.id,
        created_at:     legacy_channel.created_at,
    )
end

legacy_keywords = LegacyKeyword.all
puts "Processing #{legacy_keywords.count} keywords"
legacy_keywords.each do |legacy_keyword| 
    #puts "Creating new keyword for #{legacy_keyword.value}"
    sport = Sport.where(name: legacy_keyword.legacy_sport.name).first
    Keyword.create(
        value:          legacy_keyword.value,
        priority:       legacy_keyword.priority,
        black_flag:     legacy_keyword.black_flag,
        sport_id:       sport.id,
        created_at:     legacy_keyword.created_at,
    )
end

legacy_programs = LegacyProgram.all.limit(10)
puts "Processing #{legacy_programs.count} programs"
legacy_programs.each do |legacy_program| 
    #puts "Creating new program for #{legacy_program.title} (#{legacy_program.episode_title})"
    keyword = Keyword.where(value: legacy_program.legacy_keyword.value).first
    Program.create(
        title:          legacy_program.title,
        episode_title:  legacy_program.episode_title,
        duration:       legacy_program.duration,
        black_flag:     legacy_program.black_flag,
        keyword_id:     keyword.id,
        created_at:     legacy_program.created_at,
    )
end

legacy_broadcast_services = LegacyBroadcastService.all
puts "Processing #{legacy_broadcast_services.count} broadcast services"
legacy_broadcast_services.each do |legacy_broadcast_service| 
    #puts "Creating new program for #{legacy_program.title} (#{legacy_program.episode_title})"
    region = Region.where(name: legacy_broadcast_service.legacy_region.name).first
    channel = Channel.where(name: legacy_broadcast_service.legacy_channel.name).first
    BroadcastService.create(
        region_id:      region.id,
        channel_id:     channel.id,
        created_at:     legacy_broadcast_service.created_at,
    )
end

legacy_broadcast_events = LegacyBroadcastEvent.all.limit(500)
puts "Processing #{legacy_broadcast_events.count} broadcast events"
legacy_broadcast_events.each do |legacy_broadcast_event| 
    #puts "Creating new program for #{legacy_program.title} (#{legacy_program.episode_title})"
    legacy_program = legacy_broadcast_event.legacy_program
    legacy_broadcast_service = legacy_broadcast_event.legacy_broadcast_service
    legacy_region = legacy_broadcast_service.legacy_region
    legacy_channel = legacy_broadcast_service.legacy_channel
    region = Region.where(name: legacy_region.name).first
    channel = Channel.where(name: legacy_channel.name).first

    program = Program.where(title: legacy_program.title, episode_title: legacy_program.episode_title, duration: legacy_program.duration).first
    broadcast_service = BroadcastService.where(region_id: region.id, channel_id: channel.id).first
    BroadcastEvent.create(
        program_id:                 program.id,
        broadcast_service_id:       broadcast_service.id,
        epoch_scheduled_date:       legacy_broadcast_event.epoch_scheduled_date,
        broadcast_event_hash:       legacy_broadcast_event.broadcast_event_hash,
        created_at:                 legacy_broadcast_event.created_at,
    )
end

puts "[---- Completed ----]"
