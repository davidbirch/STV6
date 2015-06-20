class RawProgramsController < ApplicationController
  before_action :set_raw_program, only: [:show, :edit, :update, :destroy]

  def index
    if params[:layout] == "by_category"
      # GET /raw_programs?layout=by_category
      # GET /raw_programs_by_category
      @raw_programs_by_category = RawProgram.group(:category).order("count_all DESC").count
      render 'index_by_category' and return
    else
      # GET /raw_programs
      @raw_programs = RawProgram.paginate(:page => params[:page])
    end
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
      params.require(:raw_program).permit(:title, :subtitle, :category, :description, :start_datetime, :end_datetime, :region_name, :channel_xmltv_id)
    end
end
