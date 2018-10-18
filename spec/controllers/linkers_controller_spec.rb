# == Schema Information
#
# Table name: linkers
#
#  id                 :integer          not null, primary key
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

RSpec.describe LinkersController, type: :controller do

  before(:each) do
    @admin_user = FactoryBot.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @linker = FactoryBot.create(:linker)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of linkers" do
      expect(assigns(:linkers)).to eq([@linker])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @linker = FactoryBot.create(:linker)
      get :show, params: {id: @linker}
    end
        
    it "assigns the requested linker to @linker" do
      expect(assigns(:linker)).to eq(@linker)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Linker as @linker" do
      expect(assigns(:linker)).to be_a_new(Linker)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Linker" do
        expect {
          post :create, params: {linker: FactoryBot.attributes_for(:linker)}
        }.to change(Linker, :count).by(1)
      end

      it "assigns a newly created linker as @linker" do
        post :create, params: {linker: FactoryBot.attributes_for(:linker)}
        expect(assigns(:linker)).to be_a(Linker)
        expect(assigns(:linker)).to be_persisted
      end

      it "redirects to the created linker" do
        post :create, params: {linker: FactoryBot.attributes_for(:linker)}
        expect(response).to redirect_to(Linker.last)
      end
    end

  #  context "with invalid params" do
  #    it "assigns a newly created but unsaved linker as @linker" do
  #      post :create, linker: FactoryBot.attributes_for(:invalid_linker)
  #      expect(assigns(:linker)).to be_a_new(Linker)
  #    end
  #
  #    it "re-renders the 'new' template" do
  #      post :create, linker: FactoryBot.attributes_for(:invalid_linker)
  #      expect(response).to render_template("new")
  #    end
  #  end
  
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested linker as @linker" do
        linker = FactoryBot.create(:linker)
        put :update, params: {:id => linker.to_param, :linker => FactoryBot.attributes_for(:linker)}
        expect(assigns(:linker)).to eq(linker)
      end

      it "redirects to the linker" do
        linker = FactoryBot.create(:linker)
        put :update, params: {:id => linker.to_param, :linker => FactoryBot.attributes_for(:linker)}
        linker.reload
        expect(response).to redirect_to(linker)
      end
    end

  #  context "with invalid params" do
  #    it "assigns the raw_program as @raw_program" do
  #      linker = FactoryBot.create(:linker)
  #      put :update, {:id => linker.to_param, :linker => FactoryBot.attributes_for(:invalid_linker)}
  #      expect(assigns(:linker)).to eq(linker)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      linker = FactoryBot.create(:linker)
  #      put :update, {:id => linker.to_param, :linker => FactoryBot.attributes_for(:invalid_linker)}
  #      expect(response).to render_template("edit")
  #    end
  #  end
  
  end

  describe "DELETE #destroy" do
    it "destroys the requested linker" do
      linker = FactoryBot.create(:linker)
      expect {
        delete :destroy, params: {:id => linker.to_param}
      }.to change(Linker, :count).by(-1)
    end

    it "redirects to the linkers list" do
      linker = FactoryBot.create(:linker)
      delete :destroy, params: {:id => linker.to_param}
      expect(response).to redirect_to(linkers_url)
    end
  end

end
