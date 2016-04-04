# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1
  def show
    @programs = @category.programs.paginate(:page => params[:page]) unless @category.nil?
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /categories/1/set_black_flag_on
  def set_black_flag_on
    if @category.update(black_flag: true)
      redirect_to categories_url, notice: 'Keyword ' + @category.url_friendly_name + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /categories/1/set_black_flag_off
  def set_black_flag_off
    if @category.update(black_flag: false)
      redirect_to categories_url, notice: 'Keyword ' + @category.url_friendly_name + ' was successfully updated.'
    end
  end
  
  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :black_flag)
    end
end
