class ProgramRegionsChannelsController < ApplicationController
  before_filter :authenticate_user!

  # GET /programs-by-region-and-channel     
  def index
    @regions = Region.all
    @channels = Channel.all
  end
  
end
