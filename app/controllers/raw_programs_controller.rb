# == Schema Information
#
# Table name: raw_programs
#
#  id                  :integer          not null, primary key
#  program_hash        :text(65535)
#  title               :string(255)
#  subtitle            :string(255)
#  category            :string(255)
#  description         :text(65535)
#  start_datetime      :datetime
#  end_datetime        :datetime
#  region_name         :string(255)
#  channel_name        :string(255)
#  channel_free_or_pay :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class RawProgramsController < ApplicationController
  before_filter :authenticate_user!
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
      params.require(:raw_program).permit(:title, :subtitle, :category, :description, :start_datetime, :end_datetime, :region_name, :channel_free_or_pay)
    end
end
