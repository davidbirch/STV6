class RawProgramsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_raw_program, only: [:show, :edit, :update, :destroy]

  # GET /raw_programs
  def index
    @raw_programs = RawProgram.all
  end

  # GET /raw_programs/1
  def show
  end

  # GET /raw_programs/new
  def new
    @raw_program = RawProgram.new
  end

  # GET /raw_programs/1/edit
  def edit
  end

  # POST /raw_programs
  def create
    @raw_program = RawProgram.new(raw_program_params)

    if @raw_program.save
      redirect_to @raw_program, notice: 'Raw program was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /raw_programs/1
  def update
    if @raw_program.update(raw_program_params)
      redirect_to @raw_program, notice: 'Raw program was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /raw_programs/1
  def destroy
    @raw_program.destroy
    redirect_to raw_programs_url, notice: 'Raw program was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_program
      @raw_program = RawProgram.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def raw_program_params
      params.require(:raw_program).permit(:title, :subtitle, :category, :description, :start_datetime, :end_datetime, :region_name, :channel_free_or_pay)
    end
end
