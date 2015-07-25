class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  # GET /channels
  def index
    @channels = Channel.all
  end

  # GET /channels/1
  def show
    @programs = @channel.programs.paginate(:page => params[:page]) unless @channel.nil?
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      redirect_to @channel, notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /channels/1
  def update
    if @channel.update(channel_params)
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_params
      params.require(:channel).permit(:xmltv_id, :free_or_pay, :name, :short_name, :black_flag)
    end
end
