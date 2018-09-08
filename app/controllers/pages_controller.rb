class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :privacy, :contact, :unavailable]
  
  # GET /
  def home
    @title = "SPORT ON TV | Home"    
  end
  
  # GET /dashboard   
  def dashboard
  end

  # GET /privacy
  def privacy
    @title = "SPORT ON TV | Privacy Policy"
  end

# GET /contact
  def contact
    @title = "SPORT ON TV | Contact Page"
  end

# GET /unavailable
  def unavailable
    render :layout => false
  end  
end
