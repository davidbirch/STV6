class GuidesController < ApplicationController
  
  # GET /guides/:region_name
  # GET /guides/:region_name/:sport_name
  # GET /guides/:region_name/?search=:search

  def show
    @region = Region.friendly.find(params[:region_name]) if params[:region_name]
    @sport = Sport.friendly.find(params[:sport_name]) if params[:sport_name]
    @search_string = params[:search]
    
    if @search_string
      # GET /guides/:region_name/?search=:search
      @start_dates = Program.current.where(region_id: @region.id).where("title like ? or subtitle like ?", "%#{@search_string}%", "%#{@search_string}%").distinct.pluck(:local_start_date_display).sort
      @programs = @region.programs.where("title like ? or subtitle like ?", "%#{@search_string}%", "%#{@search_string}%").ordered_for_tv_guide
    elsif @sport
      # GET /guides/:region_name/:sport_name
      @start_dates = Program.current.where(region_id: @region.id).where(sport_id: @sport.id).distinct.pluck(:local_start_date_display).sort
      @programs = @region.programs.where(sport_id: @sport.id).ordered_for_tv_guide
    else
      # GET /guides/:region_name
      @start_dates = Program.current.where(region_id: @region.id).distinct.pluck(:local_start_date_display).sort
      @programs = @region.programs.ordered_for_tv_guide
     end
    
  end
  
end
