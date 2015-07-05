class ProgramRegionsDaysController < ApplicationController


  # GET /programs-by-region-and-channel     
  def index
    @regions = Region.all
    @program_days = Program.select(:start_date).distinct
  end
  
end
