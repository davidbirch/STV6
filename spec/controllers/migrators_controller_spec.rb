# == Schema Information
#
# Table name: migrators
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

RSpec.describe MigratorsController, type: :controller do

  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @migrator = FactoryGirl.create(:migrator)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of migrators" do
      expect(assigns(:migrators)).to eq([@migrator])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @migrator = FactoryGirl.create(:migrator)
      get :show, params:{id: @migrator}
    end
        
    it "assigns the requested migrator to @migrator" do
      expect(assigns(:migrator)).to eq(@migrator)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Migrator as @migrator" do
      expect(assigns(:migrator)).to be_a_new(Migrator)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Migrator" do
        expect {
          post :create, params:{migrator: FactoryGirl.attributes_for(:migrator)}
        }.to change(Migrator, :count).by(1)
      end

      it "assigns a newly created migrator as @migrator" do
        post :create, params:{migrator: FactoryGirl.attributes_for(:migrator)}
        expect(assigns(:migrator)).to be_a(Migrator)
        expect(assigns(:migrator)).to be_persisted
      end

      it "redirects to the created migrator" do
        post :create, params:{migrator: FactoryGirl.attributes_for(:migrator)}
        expect(response).to redirect_to(Migrator.last)
      end
    end

  #  context "with invalid params" do
  #    it "assigns a newly created but unsaved migrator as @migrator" do
  #      post :create, migrator: FactoryGirl.attributes_for(:invalid_migrator)
  #      expect(assigns(:migrator)).to be_a_new(Migrator)
  #    end
  #
  #    it "re-renders the 'new' template" do
  #      post :create, migrator: FactoryGirl.attributes_for(:invalid_migrator)
  #      expect(response).to render_template("new")
  #    end
  #  end
  
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested migrator as @migrator" do
        migrator = FactoryGirl.create(:migrator)
        put :update, params:{:id => migrator.to_param, :migrator => FactoryGirl.attributes_for(:empty_region_migrator)}
        expect(assigns(:migrator)).to eq(migrator)
      end

      it "redirects to the migrator" do
        migrator = FactoryGirl.create(:migrator)
        put :update, params:{:id => migrator.to_param, :migrator => FactoryGirl.attributes_for(:empty_region_migrator)}
        migrator.reload
        expect(response).to redirect_to(migrator)
      end
    end

  #  context "with invalid params" do
  #    it "assigns the raw_program as @raw_program" do
  #      migrator = FactoryGirl.create(:migrator)
  #      put :update, {:id => migrator.to_param, :migrator => FactoryGirl.attributes_for(:invalid_migrator)}
  #      expect(assigns(:migrator)).to eq(migrator)
  #    end
  #
  #    it "re-renders the 'edit' template" do
  #      migrator = FactoryGirl.create(:migrator)
  #      put :update, {:id => migrator.to_param, :migrator => FactoryGirl.attributes_for(:invalid_migrator)}
  #      expect(response).to render_template("edit")
  #    end
  #  end
  
  end

  describe "DELETE #destroy" do
    it "destroys the requested migrator" do
      migrator = FactoryGirl.create(:migrator)
      expect {
        delete :destroy, params:{:id => migrator.to_param}
      }.to change(Migrator, :count).by(-1)
    end

    it "redirects to the migrators list" do
      migrator = FactoryGirl.create(:migrator)
      delete :destroy, params:{:id => migrator.to_param}
      expect(response).to redirect_to(migrators_url)
    end
  end

end
