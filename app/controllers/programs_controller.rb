# == Schema Information
#
# Table name: programs
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  subtitle                 :string(255)
#  description              :text(65535)
#  program_hash             :text(65535)
#  start_datetime           :datetime
#  end_datetime             :datetime
#  start_date_display       :string(255)
#  local_start_date_display :string(255)
#  region_id                :integer
#  channel_id               :integer
#  sport_id                 :integer
#  keyword_id               :integer
#  category_id              :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ProgramsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  # GET /programs
  def index
    @programs = Program.paginate(:page => params[:page])
  end

  # GET /programs/1
  def show
    @programs = Program.where(title: @program.title).paginate(:page => params[:page])
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  def create
    @program = Program.new(program_params)

    if @program.save
      redirect_to @program, notice: 'Program was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /programs/1
  def update
    if @program.update(program_params)
      redirect_to @program, notice: 'Program was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /programs/1
  def destroy
    @program.destroy
    redirect_to programs_url, notice: 'Program was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def program_params
      params.require(:program).permit(:title, :subtitle, :description, :start_datetime, :end_datetime, :keyword_id, :region_id, :channel_id, :sport_id, :category_id)
    end
end
