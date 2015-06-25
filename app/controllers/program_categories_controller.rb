class ProgramCategoriesController < ApplicationController


  # GET /programs_by_category      
  def index
    @programs_by_category = Program.group(:category).order("count_all DESC").count
  end

  # GET /programs_by_categories/:category
  def show
    @programs = Program.where(category: params[:category]).paginate(:page => params[:page])
  end
  
end
