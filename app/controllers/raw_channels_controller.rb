# == Schema Information
#
# Table name: raw_channels
#
#  id            :integer          not null, primary key
#  channel_hash  :text(65535)
#  channel_name  :string(255)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class RawChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_raw_channel, only: [:show]

  # GET /raw_channels
  def index
    @raw_channels = RawChannel.paginate(:page => params[:page])
  end

  # GET /raw_channels/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_channel
      @raw_channel = RawChannel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def raw_channel_params
      params.require(:raw_channel).permit(:channel_tag)
    end
end
