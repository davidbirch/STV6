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

class BroadcastServiceRegionsController < ApplicationController
  before_action :authenticate_user!

  # GET /broadcast_services_by_region      
  def index
    @broadcast_services = BroadcastService.includes(:region, :channel, :provider)
  end

  # GET /broadcast_services_by_region/:id
  def show
    @region = Region.friendly.find(params[:id])
    @broadcast_services = @region.broadcast_services.includes(:region, :channel, :provider).paginate(:page => params[:page]) unless @region.nil?
  end

end
