class RawChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_raw_channel, only: [:show, :edit, :update, :destroy]

  # GET /raw_channels
  def index
     @raw_channels = RawChannel.all
  end

  # GET /raw_channels/1
  def show
  end

  # GET /raw_channels/new
  def new
    @raw_channel = RawChannel.new
  end

  # GET /raw_channels/1/edit
  def edit
  end

  # POST /raw_channels
  def create
    @raw_channel = RawChannel.new(raw_channel_params)

    if @raw_channel.save
      redirect_to @raw_channel, notice: 'Raw channel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /raw_channels/1
  def update
    if @raw_channel.update(raw_channel_params)
      redirect_to @raw_channel, notice: 'Raw channel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /raw_channels/1
  def destroy
    @raw_channel.destroy
    redirect_to raw_channels_url, notice: 'Raw channel was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_channel
      @raw_channel = RawChannel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def raw_channel_params
      params.require(:raw_channel).permit(:free_or_pay, :channel_name)
    end
end
