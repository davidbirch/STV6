class ProgramCategoriesController < ApplicationController


  # GET /programs_by_category      
  def index
    @programs_by_category = Program.group(:url_friendly_category).order("count_all DESC").count
  end

  # GET /programs_by_categories/:id
  def show
    @programs = Program.where(url_friendly_category: params[:id]).paginate(:page => params[:page])
  end
  
end
