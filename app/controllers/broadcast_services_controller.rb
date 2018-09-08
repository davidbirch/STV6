# == Schema Information
#
# Table name: broadcast_services
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BroadcastServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_broadcast_service, only: [:show, :edit, :update, :destroy]

  # GET /broadcast-services
  def index
    @broadcast_services = BroadcastService.includes(:region, :channel).paginate(:page => params[:page])
  end

  # GET /broadcast-services/1
  def show
    @broadcast_events = @broadcast_service.broadcast_events.paginate(:page => params[:page]) unless @broadcast_service.nil?
  end

  # GET /broadcast-services/new
  def new
    @broadcast_service = BroadcastService.new
  end

  # GET /broadcast-services/1/edit
  def edit
  end

  # POST /broadcast-services
  def create
    @broadcast_service = BroadcastService.new(broadcast_service_params)
    
    if @broadcast_service.save
      redirect_to @broadcast_service, notice: 'Broadcast Service was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clebroadcast-servicesners/1
  def update
    if @broadcast_service.update(broadcast_service_params)
      redirect_to @broadcast_service, notice: 'Broadcast Service was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /broadcast-services/1
  def destroy
    @broadcast_service.destroy
    redirect_to broadcast_services_url, notice: 'Broadcast Service was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_broadcast_service
      @broadcast_service = BroadcastService.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def broadcast_service_params
      params.require(:broadcast_service).permit(:region_id, :channel_id)
    end
end
