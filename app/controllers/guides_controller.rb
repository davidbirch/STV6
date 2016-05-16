class GuidesController < ApplicationController
  
  # GET /guides/:region_name
  def index
    set_meta_variables
  end
  
  # GET /guides/:region_name/:sport_name
  # GET /guides/:region_name/?search=:search
  def show
    if params[:sport_name] && params[:sport_name] != params[:sport_name].downcase
      # handle old URLs with uppercase sport name, special case for some sports
      case params[:sport_name]
      when "Other Sport"
        new_downcase_path = ("/" + params[:region_name] + "/" + "other-sport").downcase
      when "Motor Sports"
        new_downcase_path = ("/" + params[:region_name] + "/" + "motor-sports").downcase
      when "Rugby League"
        new_downcase_path = ("/" + params[:region_name] + "/" + "rugby-league").downcase
      when "Rugby Union"
        new_downcase_path = ("/" + params[:region_name] + "/" + "rugby-union").downcase
      when "American Football"
        new_downcase_path = ("/" + params[:region_name] + "/" + "american-football").downcase
      when "Cue Sports"
        new_downcase_path = ("/" + params[:region_name] + "/" + "cue-sports").downcase
      when "Ice Hockey"
        new_downcase_path = ("/" + params[:region_name] + "/" + "ice-hockey").downcase
      when "Lawn Bowls"
        new_downcase_path = ("/" + params[:region_name] + "/" + "lawn-bowls").downcase 
      else
        new_downcase_path = ("/" + params[:region_name] + "/" + params[:sport_name]).downcase
      end 
      redirect_to new_downcase_path, status: 301
    elsif params[:region_name] && params[:region_name] != params[:region_name].downcase
      # handle old URLs with uppercase region name      
      new_downcase_path = ("/" + params[:region_name]).downcase
      redirect_to new_downcase_path, status: 301
    else
      set_meta_variables
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
