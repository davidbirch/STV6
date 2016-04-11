class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:privacy, :contact, :unavailable]
  
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
