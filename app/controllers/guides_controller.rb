class GuidesController < ApplicationController
  before_action :set_guide_variables, only: [:index, :show]

  
  # GET /guides/:region_name
  def index

  end
  
  # GET /guides/:region_name/:sport_name
  # GET /guides/:region_name/?search=:search
  def show
    @search_string = params[:search]     
    if @search_string
      # GET /guides/:region_name/?search=:search
      @broadcast_events = @region.broadcast_events.joins(:program).where("programs.title like ? or programs.episode_title like ?", "%#{@search_string}%", "%#{@search_string}%").includes(:program, :broadcast_service, :region, :channel, :keyword, :sport).ordered_for_tv_guide
    elsif @sport
      # GET /guides/:region_name/:sport_name   
      @broadcast_events = @region.broadcast_events.where(sports: {id: @sport.id}).includes(:program, :broadcast_service, :region, :channel, :keyword, :sport).ordered_for_tv_guide
    else
      # GET /guides/:region_name
      @broadcast_events = @region.broadcast_events.includes(:program, :broadcast_service, :region, :channel, :keyword, :sport).ordered_for_tv_guide
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guide_variables
      @region = Region.friendly.find(params[:region_name]) if params[:region_name]
      @sport = Sport.friendly.find(params[:sport_name]) if params[:sport_name]
      
    end
    
end
