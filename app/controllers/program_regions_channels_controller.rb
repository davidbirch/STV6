class ProgramRegionsChannelsController < ApplicationController


  # GET /programs-by-region-and-channel     
  def index
    @regions = Region.all
    @channels = Channel.all
  end
  
end
