# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  email      :string(255)
#  source     :text(65535)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :uid, :provider, :nickname, :image, :email, :source)
    end
    
end
