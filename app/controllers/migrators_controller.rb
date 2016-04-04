# == Schema Information
#
# Table name: migrators
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class MigratorsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_migrator, only: [:show, :edit, :update, :destroy]

  # GET /migrators
  def index
    @migrators = Migrator.all.by_requested_at
  end

  # GET /migrators/1
  def show
  end

  # GET /migrators/new
  def new
    @migrator = Migrator.new
  end

  # GET /migrators/1/edit
  def edit
  end

  # POST /migrators
  def create
    @migrator = Migrator.new(migrator_params)
    @migrator.requested_by = @current_user.name


    if @migrator.save
      redirect_to @migrator, notice: 'Migrator was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /migrators/1
  def update
    if @migrator.update(migrator_params)
      redirect_to @migrator, notice: 'Migrator was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /migrators/1
  def destroy
    @migrator.destroy
    redirect_to migrators_url, notice: 'Migrator was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_migrator
      @migrator = Migrator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def migrator_params
      params.require(:migrator).permit(:target_region_list, :requested_by)
    end
end
