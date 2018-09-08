# == Schema Information
#
# Table name: raw_programs
#
#  id                    :integer          not null, primary key
#  summary_program_hash  :text(65535)
#  detailed_program_hash :text(65535)
#  channel_tag           :string(255)
#  region_lookup         :string(255)
#  region_name           :string(255)
#  placeholder           :boolean
#  title                 :string(255)
#  event_lookup          :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class RawProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_raw_program, only: [:show]

  # GET /raw_programs
  def index
    @raw_programs = RawProgram.paginate(:page => params[:page])
  end

  # GET /raw_programs/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raw_program
      @raw_program = RawProgram.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def raw_program_params
      params.require(:raw_program).permit(:channel_tag)
    end
end
