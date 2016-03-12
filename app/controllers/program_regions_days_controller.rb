class ProgramRegionsDaysController < ApplicationController
  before_filter :authenticate_user! && :check_admin_user!

  # GET /programs-by-region-and-day     
  def index
    @regions = Region.all
    @programs_by_day = Program.group(:start_date_display).order("start_date_display ASC").count
  end
  
end
