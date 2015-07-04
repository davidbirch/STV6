class ProgramCategoriesController < ApplicationController


  # GET /programs_by_category      
  def index
    @programs_by_category = Program.group(:url_friendly_category).order("count_all DESC").count
  end

  # GET /programs_by_categories/:url_friendly_category
  def show
    @programs = Program.where(url_friendly_category: params[:url_friendly_category]).paginate(:page => params[:page])
  end
  
end
