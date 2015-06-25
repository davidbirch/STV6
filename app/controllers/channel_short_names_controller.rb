class ChannelShortNamesController < ApplicationController


  # GET /channels_by_short_name      
  def index
    @channels = Channel.all
  end

  # GET /channels_by_short_name/:short_name
  def show
    @channels = Channel.where(short_name: params[:short_name])
  end

end
