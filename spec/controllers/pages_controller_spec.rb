require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    before :each do
      get :home
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "renders the :home view" do
      expect(response).to render_template :home
    end  
  end
  
  describe "GET #about" do
    before :each do
      get :about
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "renders the :about view" do
      expect(response).to render_template :about
    end  
  end

end
