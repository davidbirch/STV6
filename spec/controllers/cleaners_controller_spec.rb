# == Schema Information
#
# Table name: cleaners
#
#  id                 :integer          not null, primary key
#  target_region_list :text(65535)
#  log                :text(65535)
#  status             :string(255)
#  requested_by       :string(255)
#  requested_at       :datetime
#  started_at         :datetime
#  completed_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe CleanersController, type: :controller do

  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @cleaner = FactoryGirl.create(:cleaner)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of cleaners" do
      expect(assigns(:cleaners)).to eq([@cleaner])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @cleaner = FactoryGirl.create(:cleaner)
      get :show, params: {id: @cleaner}
    end
        
    it "assigns the requested cleaner to @cleaner" do
      expect(assigns(:cleaner)).to eq(@cleaner)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Cleaner as @cleaner" do
      expect(assigns(:cleaner)).to be_a_new(Cleaner)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Cleaner" do
        expect {
          post :create, params: {cleaner: FactoryGirl.attributes_for(:cleaner)}
        }.to change(Cleaner, :count).by(1)
      end

      it "assigns a newly created cleaner as @cleaner" do
        post :create, params: {cleaner: FactoryGirl.attributes_for(:cleaner)}
        expect(assigns(:cleaner)).to be_a(Cleaner)
        expect(assigns(:cleaner)).to be_persisted
      end

      it "redirects to the created cleaner" do
        post :create, params: {cleaner: FactoryGirl.attributes_for(:cleaner)}
        expect(response).to redirect_to(Cleaner.last)
      end
    end

  #  context "with invalid params" do
  #    it "assigns a newly created but unsaved cleaner as @cleaner" do
  #      post :create, cleaner: FactoryGirl.attributes_for(:invalid_cleaner)
  #      expect(assigns(:cleaner)).to be_a_new(Cleaner)
  #    end
  #
  #    it "re-renders the 'new' template" do
  #      post :create, cleaner: FactoryGirl.attributes_for(:invalid_cleaner)
  #      expect(response).to render_template("new")
  #    end
  #  end
  
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested cleaner as @cleaner" do
        cleaner = FactoryGirl.create(:cleaner)
        put :update, params: {:id => cleaner.to_param, :cleaner => FactoryGirl.attributes_for(:cleaner)}
        expect(assigns(:cleaner)).to eq(cleaner)
      end

      it "redirects to the cleaner" do
        cleaner = FactoryGirl.create(:cleaner)
        put :update, params: {:id => cleaner.to_param, :cleaner => FactoryGirl.attributes_for(:cleaner)}
        cleaner.reload
        expect(response).to redirect_to(cleaner)
      end
    end

  #  context "with invalid params" do
  #    it "assigns the raw_program as @raw_program" do
  #      cleaner = FactoryGirl.create(:cleaner)
  #      put :update, {:id => cleaner.to_param, :cleaner => FactoryGirl.attributes_for(:invalid_cleaner)}
  #      expect(assigns(:cleaner)).to eq(cleaner)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      cleaner = FactoryGirl.create(:cleaner)
  #      put :update, {:id => cleaner.to_param, :cleaner => FactoryGirl.attributes_for(:invalid_cleaner)}
  #      expect(response).to render_template("edit")
  #    end
  #  end
  
  end

  describe "DELETE #destroy" do
    it "destroys the requested cleaner" do
      cleaner = FactoryGirl.create(:cleaner)
      expect {
        delete :destroy, params: {:id => cleaner.to_param}
      }.to change(Cleaner, :count).by(-1)
    end

    it "redirects to the cleaners list" do
      cleaner = FactoryGirl.create(:cleaner)
      delete :destroy, params: {:id => cleaner.to_param}
      expect(response).to redirect_to(cleaners_url)
    end
  end

end
