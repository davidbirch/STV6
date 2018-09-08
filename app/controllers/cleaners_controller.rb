# == Schema Information
#
# Table name: cleaners
#
#  id         :integer          not null, primary key
#
#
#  job_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CleanersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]

  # GET /cleaners
  def index
    @cleaners = Cleaner.by_created_at.paginate(:page => params[:page])
  end

  # GET /cleaners/1
  def show
  end

  # GET /cleaners/new
  def new
    @cleaner = Cleaner.new
  end

  # GET /cleaners/1/edit
  def edit
  end

  # POST /cleaners
  def create
    @cleaner = Cleaner.new(cleaner_params)
    @cleaner.requested_by = @current_user.name
    
    if @cleaner.save
      redirect_to @cleaner, notice: 'Cleaner was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cleaners/1
  def update
    if @cleaner.update(cleaner_params)
      redirect_to @cleaner, notice: 'Cleaner was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cleaners/1
  def destroy
    @cleaner.destroy
    redirect_to cleaners_url, notice: 'Cleaner was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleaner
      @cleaner = Cleaner.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cleaner_params
      params.require(:cleaner).permit(:clean_raw_programs, :clean_raw_channels, :clean_broadcast_events, :clean_historic_broadcast_events, :clean_programs, :clean_channels, :clean_broadcast_services, :requested_by)
    end
end

