class GuidesController < ApplicationController
  before_action :set_guide_variables, only: [:index, :show]

  
  # GET / (root)
  def index

  end
  
  # GET /guides/:region_name
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
       
      "Sport on TV | " + temp_sport + " on Television in "+ temp_region + " | Live " + temp_sport + " on TV"
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
       
      "#{temp_sport.downcase}, #{temp_region}, live, HD, 4K, tv guide, television, coverage, tonight, free to air, freeview, pay tv"
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
       
      "Your tv guide for #{temp_sport} in #{temp_region}.  Coverage of all #{temp_sport} on television.  Watch live #{temp_sport} on Free-to-air, Freeview, or Pay TV."   
    end
    
end
