# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  url_friendly_value :string(255)
#  sport_id           :integer
#  priority           :integer
#  black_flag         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class KeywordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_keyword, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /keywords
  def index
    @keywords = Keyword.includes(:sport).order("priority DESC, length(value) DESC")
  end

  # GET /keywords/1
  def show
    @programs = @keyword.programs.paginate(:page => params[:page]) unless @keyword.nil?
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  def create
    @keyword = Keyword.new(keyword_params)

    if @keyword.save
      redirect_to @keyword, notice: 'Keyword was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      redirect_to @keyword, notice: 'Keyword was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /keywords/1/set_black_flag_on
  def set_black_flag_on
    if @keyword.update(black_flag: true)
      redirect_to keywords_url, notice: 'Keyword ' + @keyword.url_friendly_value + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /keywords/1/set_black_flag_off
  def set_black_flag_off
    if @keyword.update(black_flag: false)
      redirect_to keywords_url, notice: 'Keyword ' + @keyword.url_friendly_value + ' was successfully updated.'
    end
  end
  
  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: 'Keyword was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def keyword_params
      params.require(:keyword).permit(:value, :sport_id, :priority, :black_flag)
    end
end
