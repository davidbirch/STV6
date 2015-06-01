class ConversionSummariesController < ApplicationController
  before_action :set_conversion_summary, only: [:show]

  # GET /conversion_summaries
  def index
    @conversion_summaries = ConversionSummary.paginate(:page => params[:page])
  end

  # GET /conversion_summaries/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversion_summary
      @conversion_summary = ConversionSummary.find(params[:id])
    end

end
