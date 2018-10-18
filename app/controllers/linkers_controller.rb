# == Schema Information
#
# Table name: linkers
#
#  id         :integer          not null, primary key
#
#
#  job_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LinkersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_linker, only: [:show, :edit, :update, :destroy]

  # GET /linker
  def index
    @linkers = Linker.by_created_at.paginate(:page => params[:page])
  end

  # GET /linkers/1
  def show
  end

  # GET /linkers/new
  def new
    @linker = Linker.new
  end

  # GET /linkers/1/edit
  def edit
  end

  # POST /linkers
  def create
    @linker = Linker.new(linker_params)
    @linker.requested_by = @current_user.name
    
    if @linker.save
      redirect_to @linker, notice: 'Linker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /linkers/1
  def update
    if @linker.update(linker_params)
      redirect_to @linker, notice: 'Linker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /linkers/1
  def destroy
    @linker.destroy
    redirect_to linkers_url, notice: 'Linker was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linker
      @linker = Linker.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def linker_params
      params.require(:linker).permit(:requested_by)
    end
end

