class GuidesController < ApplicationController
  
  before_action :set_meta_variables, only: [:index, :show]
  
  # GET /guides/:region_name
  def index
  end
  
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
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meta_variables
      @region = Region.friendly.find(params[:region_name]) if params[:region_name]
      @sport = Sport.friendly.find(params[:sport_name]) if params[:sport_name]
        
      @title = page_title
      @meta_keywords = page_meta_keywords
      @meta_description = page_meta_description  
    end
  
    def page_title  
      if @sport.nil?
        temp_sport = "Sport"
      else
        temp_sport = @sport.name
      end
      
      if @region.nil?
        temp_region = "Australia"
      else
        temp_region = @region.name+", Australia"
      end
       
      "SPORT ON TV | " + temp_sport + " on Television in "+ temp_region + " | Live " + temp_sport + " on TV"
    end
    
    def page_meta_keywords
      if @sport.nil?
        temp_sport = "Sport"
      else
        temp_sport = @sport.name
      end
      
      if @region.nil?
        temp_region = "Australia"
      else
        temp_region = @region.name+", Australia"
      end
       
      "tv guide, television, coverage, tonight, free to air, freeview, pay tv, live, #{temp_sport.downcase}, #{temp_region}"
    end
    
    def page_meta_description  
      if @sport.nil?
        temp_sport = "Sport"
      else
        temp_sport = @sport.name
      end
      
      if @region.nil?
        temp_region = "Australia"
      else
        temp_region = @region.name+", Australia"
      end
       
      "Your tv guide for #{temp_sport.downcase} in #{temp_region}.  Coverage of all #{temp_sport.downcase} on television.  Watch live #{temp_sport.downcase} on Free-to-air, Freeview, or Pay TV."   
    end
  
end
