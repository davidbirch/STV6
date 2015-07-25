class ProgramDaysController < ApplicationController
  before_filter :authenticate_user!


  # GET /programs-by-day      
  def index
    @programs_by_day = Program.group(:start_date_display).order("start_date_display ASC").count
  end
  
  # GET /programs-by-day/:id
  def show
    @programs = Program.where(start_date_display: params[:id]).paginate(:page => params[:page])
  end
  
end
