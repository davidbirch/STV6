# == Schema Information
#
# Table name: channels
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  url_friendly_name       :string(255)
#  short_name              :string(255)
#  url_friendly_short_name :string(255)
#  region_id               :integer
#  provider_id             :integer
#  black_flag              :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /channels
  def index
    @channels = Channel.includes(:provider)
  
  end

  # GET /channels/1
  def show
    @regions = @channel.regions unless @channel.nil?
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

  # PATCH/PUT /channels/1/set_black_flag_on
  def set_black_flag_on
    if @channel.update(black_flag: true)
      redirect_to channels_url, notice: 'Channel ' + @channel.url_friendly_name + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /channels/1/set_black_flag_off
  def set_black_flag_off
    if @channel.update(black_flag: false)
      redirect_to channels_url, notice: 'Channel ' + @channel.url_friendly_name + ' was successfully updated.'
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
      params.require(:channel).permit(:name, :short_name, :tag, :black_flag, :four_k_flag, :default_sport, :provider_id, :channel_hash)
    end
end
