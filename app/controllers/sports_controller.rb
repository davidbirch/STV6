# == Schema Information
#
# Table name: sports
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class SportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sport, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /sports
  def index
    @sports = Sport.includes(:keywords)
    @daily_data_labels, @daily_data_series_names, @daily_data_series = Sport.event_time_series_data_points_by_day_and_sport
  end

  # GET /sports/1
  def show
    @keywords = @sport.keywords.order("priority DESC, length(value) DESC") unless @sport.nil?
  end

  # GET /sports/new
  def new
    @sport = Sport.new
  end

  # GET /sports/1/edit
  def edit
  end

  # POST /sports
  def create
    @sport = Sport.new(sport_params)

    if @sport.save
      redirect_to @sport, notice: 'Sport was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sports/1
  def update
    if @sport.update(sport_params)
      redirect_to @sport, notice: 'Sport was successfully updated.'
    else
      render :edit
    end
  end
    
  # PATCH/PUT /sports/1/set_black_flag_on
  def set_black_flag_on
    if @sport.update(black_flag: true)
      redirect_to sports_url, notice: 'Sport ' + @sport.url_friendly_name + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /sports/1/set_black_flag_off
  def set_black_flag_off
    if @sport.update(black_flag: false)
      redirect_to sports_url, notice: 'Sport ' + @sport.url_friendly_name + ' was successfully updated.'
    end
  end

  # DELETE /sports/1
  def destroy
    @sport.destroy
    redirect_to sports_url, notice: 'Sport was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport
      @sport = Sport.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sport_params
      params.require(:sport).permit(:name, :black_flag)
    end
end
