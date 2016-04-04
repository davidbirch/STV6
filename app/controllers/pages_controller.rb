class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:privacy, :contact, :unavailable]
  
  # GET /dashboard   
  def dashboard 
  end

  # GET /privacy
  def privacy 
  end

# GET /contact
  def contact  
  end

# GET /unavailable
  def unavailable
    render :layout => false
  end  
end
