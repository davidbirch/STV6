# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  log          :text(65535)
#  status       :string(255)
#  requested_by :string(255)
#  requested_at :datetime
#  started_at   :datetime
#  completed_at :datetime
#  detail_id    :integer
#  detail_type  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class JobsController < ApplicationController
  before_action :authenticate_user!

  # GET /migrators
  def index
    @jobs = Job.includes(:detail).by_created_at.paginate(:page => params[:page])
  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
  end

end
