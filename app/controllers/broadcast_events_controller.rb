# == Schema Information
#
# Table name: broadcast_events
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BroadcastEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_broadcast_event, only: [:show, :edit, :update, :destroy]

  # GET /broadcast-services
  def index
    @broadcast_events = BroadcastEvent.includes(:program, :broadcast_service, :region, :channel, :keyword, :sport).paginate(:page => params[:page])
  end

  # GET /broadcast-services/1
  def show
  end

  # GET /broadcast-services/new
  def new
    @broadcast_event = BroadcastEvent.new
  end

  # GET /broadcast-services/1/edit
  def edit
  end

  # POST /broadcast-services
  def create
    @broadcast_event = BroadcastEvent.new(broadcast_event_params)
    
    if @broadcast_event.save
      redirect_to @broadcast_event, notice: 'Broadcast Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clebroadcast-servicesners/1
  def update
    if @broadcast_event.update(broadcast_event_params)
      redirect_to @broadcast_event, notice: 'Broadcast Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /broadcast-services/1
  def destroy
    @broadcast_event.destroy
    redirect_to broadcast_events_url, notice: 'Broadcast Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_broadcast_event
      @broadcast_event = BroadcastEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def broadcast_event_params
      params.require(:broadcast_event).permit(:program_id, :broadcast_service_id, :broadcast_event_hash, :epoch_scheduled_date, :formatted_local_start_date, :formatted_scheduled_date, :formatted_end_date)
    end
end
