class SessionsController < ApplicationController
  
  def new
    redirect_to "/auth/twitter"
  end
  
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    reset_session
    session[:user_id] = user.id
    if user.admin?
      redirect_to dashboard_url, notice: "Signed in with 'admin' privileges!"
    else
      redirect_to root_url, notice: "Signed in!"
    end
    
    
  end
  
  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out!"
  end
  
  def failure
    redirect_to root_url, alert: "Sorry, could not log you in..."
  end
    
end