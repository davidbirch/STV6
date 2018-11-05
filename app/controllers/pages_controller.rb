class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :privacy, :contact, :unavailable]
  
  # GET /
  def home
    @title = "Sport on TV | Home"    
  end
  
  # GET /dashboard   
  def dashboard
    @title = "Sport on TV | Dashboard"
  end

  # GET /privacy
  def privacy
    @title = "Sport on TV | Privacy Policy"
  end

# GET /contact
  def contact
    @title = "Sport on TV | Contact Page"
  end

# GET /unavailable
  def unavailable
    render :layout => false
  end  
end
