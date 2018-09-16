# == Schema Information
#
# Table name: regions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class RegionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_region, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /regions
  def index
    @regions =  Region.includes(:channels)
  end

  # GET /regions/1
  def show
    @broadcast_services = @region.broadcast_services.paginate(:page => params[:page]) unless @region.nil?
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  def create
    @region = Region.new(region_params)

    if @region.save
      redirect_to @region, notice: 'Region was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /regions/1
  def update
    if @region.update(region_params)
      redirect_to @region, notice: 'Region was successfully updated.'
    else
      render :edit
    end
  end
  
  # PATCH/PUT /regions/1/set_black_flag_on
  def set_black_flag_on
    if @region.update(black_flag: true)
      redirect_to regions_url, notice: 'Region ' + @region.url_friendly_name + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /regions/1/set_black_flag_off
  def set_black_flag_off
    if @region.update(black_flag: false)
      redirect_to regions_url, notice: 'Region ' + @region.url_friendly_name + ' was successfully updated.'
    end
  end

  # DELETE /regions/1
  def destroy
    @region.destroy
    redirect_to regions_url, notice: 'Region was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def region_params
      params.require(:region).permit(:name, :black_flag, :region_lookup, :time_zone_name)
    end
end
