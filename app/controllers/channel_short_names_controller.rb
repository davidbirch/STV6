class ChannelShortNamesController < ApplicationController
  before_filter :authenticate_user!

  # GET /channels_by_short_name      
  def index
    @channels = Channel.all
  end

  # GET /channels_by_short_name/:id
  def show
    @channels = Channel.where(url_friendly_short_name: params[:id])
  end

end
