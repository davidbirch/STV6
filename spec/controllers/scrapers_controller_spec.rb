# == Schema Information
#
# Table name: scrapers
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  days_to_gather     :float(24)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe ScrapersController, type: :controller do
  
  before(:each) do
    @admin_user = FactoryBot.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @scraper = FactoryBot.create(:scraper)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of scrapers" do
      expect(assigns(:scrapers)).to eq([@scraper])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @scraper = FactoryBot.create(:scraper)
      get :show, params:{id: @scraper}
    end
        
    it "assigns the requested scraper to @scraper" do
      expect(assigns(:scraper)).to eq(@scraper)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new scraper as @scraper" do
      expect(assigns(:scraper)).to be_a_new(Scraper)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new scraper" do
        expect {
          post :create, params:{scraper: FactoryBot.attributes_for(:scraper)}
        }.to change(Scraper, :count).by(1)
      end

      it "assigns a newly created scraper as @scraper" do
        post :create, params:{scraper: FactoryBot.attributes_for(:scraper)}
        expect(assigns(:scraper)).to be_a(Scraper)
        expect(assigns(:scraper)).to be_persisted
      end

      it "redirects to the created scraper" do
        post :create, params:{scraper: FactoryBot.attributes_for(:scraper)}
        expect(response).to redirect_to(Scraper.last)
      end
    end

   # context "with invalid params" do
   #   it "assigns a newly created but unsaved scraper as @scraper" do
   #     post :create, scraper: FactoryBot.attributes_for(:invalid_scraper)
   #     expect(assigns(:scraper)).to be_a_new(Scraper)
   #   end
   #
   #   it "re-renders the 'new' template" do
   #     post :create, scraper: FactoryBot.attributes_for(:invalid_scraper)
   #     expect(response).to render_template("new")
   #   end
   # end
  
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested scraper as @scraper" do
        scraper = FactoryBot.create(:scraper)
        put :update, params: {:id => scraper.to_param, :scraper => FactoryBot.attributes_for(:empty_region_scraper)}
        expect(assigns(:scraper)).to eq(scraper)
      end

      it "redirects to the scraper" do
        scraper = FactoryBot.create(:scraper)
        put :update, params: {:id => scraper.to_param, :scraper => FactoryBot.attributes_for(:empty_region_scraper)}
        scraper.reload
        expect(response).to redirect_to(scraper)
      end
    end

  #  context "with invalid params" do
  #    it "assigns the raw_program as @raw_program" do
  #      scraper = FactoryBot.create(:scraper)
  #      put :update, {:id => scraper.to_param, :scraper => FactoryBot.attributes_for(:invalid_scraper)}
  #      expect(assigns(:scraper)).to eq(scraper)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      scraper = FactoryBot.create(:scraper)
  #      put :update, {:id => scraper.to_param, :scraper => FactoryBot.attributes_for(:invalid_scraper)}
  #      expect(response).to render_template("edit")
  #    end
  #  end
  
  end

  describe "DELETE #destroy" do
    it "destroys the requested scraper" do
      scraper = FactoryBot.create(:scraper)
      expect {
        delete :destroy, params: {:id => scraper.to_param}
      }.to change(Scraper, :count).by(-1)
    end

    it "redirects to the scrapers list" do
      scraper = FactoryBot.create(:scraper)
      delete :destroy, params: {:id => scraper.to_param}
      expect(response).to redirect_to(scrapers_url)
    end
  end

end
