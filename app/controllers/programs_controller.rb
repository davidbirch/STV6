# == Schema Information
#
# Table name: programs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  episode_title :string(255)
#  program_hash  :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_program, only: [:show, :edit, :update, :destroy, :set_black_flag_on, :set_black_flag_off]

  # GET /programs
  def index
    @programs = Program.paginate(:page => params[:page])
  end

  # GET /programs/1
  def show
    @broadcast_events = @program.broadcast_events.paginate(:page => params[:page]) unless @program.nil?
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
  
   # PATCH/PUT /programs/1/set_black_flag_on
  def set_black_flag_on
    if @program.update(black_flag: true)
      redirect_to programs_url, notice: 'Program ' + @program.id.to_s + ' was successfully updated.'
    end
  end
  
  # PATCH/PUT /programs/1/set_black_flag_off
  def set_black_flag_off
    if @program.update(black_flag: false)
      redirect_to programs_url, notice: 'Program ' + @program.id.to_s + ' was successfully updated.'
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
      params.require(:program).permit(:title, :episode_title, :duration, :black_flag, :keyword_id)
    end
end
