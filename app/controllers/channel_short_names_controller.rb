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

class ChannelShortNamesController < ApplicationController
  before_action :authenticate_user!

  # GET /channels_by_short_name      
  def index
    @channels = Channel.all
  end

  # GET /channels_by_short_name/:id
  def show
    @channels = Channel.where(url_friendly_short_name: params[:id])
  end

end
