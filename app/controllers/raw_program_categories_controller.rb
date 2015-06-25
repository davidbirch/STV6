class RawProgramCategoriesController < ApplicationController


  # GET /raw_programs_by_category      
  def index
    @raw_programs_by_category = RawProgram.group(:category).order("count_all DESC").count
  end

  # GET /raw_programs_by_categories/:category
  def show
    @raw_programs = RawProgram.where(category: params[:category]).paginate(:page => params[:page])
  end

end
