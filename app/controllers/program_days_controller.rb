class ProgramDaysController < ApplicationController


  # GET /programs-by-day      
  def index
    @programs_by_day = Program.group(:start_date_display).order("start_date_display ASC").count
  end
  
  # GET /programs-by-day/:day
  def show
    @programs = Program.where(start_date_display: params[:day]).paginate(:page => params[:page])
  end
  
end
