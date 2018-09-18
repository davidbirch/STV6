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

class BroadcastServiceProviderRegionsController < ApplicationController
  before_action :authenticate_user!

  # GET /broadcast_services_by_region_and_provider      
  def index
    @providers = Provider.includes(:channels, :broadcast_services)
  end

  # GET /broadcast_services_by_region_and_provider/:id
  def show
    @provider = Provider.friendly.find(params[:provider_id])
    @region = Region.friendly.find(params[:region_id])
    @broadcast_services = @provider.broadcast_services.where(region_id: @region.id).includes(:region, :channel, :provider).paginate(:page => params[:page], :per_page => 300) unless @provider.nil?
  end

end
