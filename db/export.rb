
require "csv"
CSV.open("db/data/program_data.csv", "wb") do |csv|
  csv << ["ID", "Program Title", "Sport Flag", "Sport"]
  Program.includes(:keyword).each do |program|
    csv << [program.id, program.formatted_full_title, program.sport_flag, program.sport_name]
  end
end
