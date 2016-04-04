class ProgramRegionsSportsController < ApplicationController
  before_filter :authenticate_user!

  # GET /programs-by-region-and-sport      
  def index
    @regions = Region.all
    @sports = Sport.all
  end
  
end
