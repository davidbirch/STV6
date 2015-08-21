class GuidesController < ApplicationController
  
  # GET /guides/:region_name
  # GET /guides/:region_name/:sport_name
  def show
    @region = Region.friendly.find(params[:region_name]) if params[:region_name]
    @sport = Sport.friendly.find(params[:sport_name]) if params[:sport_name]
    @start_dates = Program.where(region_id: @region.id).distinct.pluck(:local_start_date_display).sort

    @programs = @region.programs.ordered_for_tv_guide
  end
  
end
