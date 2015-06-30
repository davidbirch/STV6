class ProgramRegionsSportsController < ApplicationController


  # GET /programs-by-region-and-sport      
  def index
    @regions = Region.all
    @sports = Sport.all
  end
  
end
