class GuidesController < ApplicationController
  before_filter :authenticate_user!

  # GET /guides      
  def index
    @regions = Region.all
    @start_dates = Program.distinct.pluck(:local_start_date_display).sort
    @guides = Program.distinct.pluck(:region_id, :local_start_date_display)
  end

  # GET /guides/:region_id
  # GET /guides/:region_id/:sport_id
  def show
    @region = Region.friendly.find(params[:id])
    @start_dates = Program.where(region_id: @region.id).distinct.pluck(:local_start_date_display).sort

    @programs = @region.programs.ordered_for_tv_guide
  end
  
end
