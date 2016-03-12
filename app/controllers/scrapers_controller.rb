class ScrapersController < ApplicationController
  before_filter :authenticate_user! && :check_admin_user!
  before_action :set_scraper, only: [:show, :edit, :update, :destroy]

  # GET /scrapers
  def index
    @scrapers = Scraper.all
  end

  # GET /scrapers/1
  def show
  end

  # GET /scrapers/new
  def new
    @scraper = Scraper.new
  end

  # GET /scrapers/1/edit
  def edit
  end

  # POST /scrapers
  def create
    @scraper = Scraper.new(scraper_params)

    if @scraper.save
      redirect_to @scraper, notice: 'Scraper was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /scrapers/1
  def update
    if @scraper.update(scraper_params)
      redirect_to @scraper, notice: 'Scraper was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /scrapers/1
  def destroy
    @scraper.destroy
    redirect_to scrapers_url, notice: 'Scraper was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scraper
      @scraper = Scraper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scraper_params
      params.require(:scraper).permit(:target_region_list, :log, :days_to_gather, :status)
    end
end
