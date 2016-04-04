# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @category = FactoryGirl.create(:category)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of categories" do
      expect(assigns(:categories)).to eq([@category])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @category = FactoryGirl.create(:category)
      get :show, id: @category
    end
        
    it "assigns the requested category to @category" do
      expect(assigns(:category)).to eq(@category)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Category as @category" do
      expect(assigns(:category)).to be_a_new(Category)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, category: FactoryGirl.attributes_for(:category)
        }.to change(Category.unscoped, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, category: FactoryGirl.attributes_for(:invalid_category)
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, category: FactoryGirl.attributes_for(:invalid_category)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested category as @category" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => FactoryGirl.attributes_for(:movie_category)}
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => FactoryGirl.attributes_for(:movie_category)}
        category.reload
        expect(response).to redirect_to(category)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => FactoryGirl.attributes_for(:invalid_category)}
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = FactoryGirl.create(:category)
        put :update, {:id => category.to_param, :category => FactoryGirl.attributes_for(:invalid_category)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = FactoryGirl.create(:category)
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category.unscoped, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = FactoryGirl.create(:category)
      delete :destroy, {:id => category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end
  
  describe "PUT #set_black_flag_on" do
    it "sets the black_flag field to true" do
      category = FactoryGirl.create(:category)
      put :set_black_flag_on, {:id => category.to_param}
      category.reload
      expect(category.black_flag?).to be true
    end
    
    it "redirects to the categories index" do
      category = FactoryGirl.create(:category)
      put :set_black_flag_on, {:id => category.to_param}
      category.reload
      expect(response).to redirect_to(categories_url)
    end
  end
  
  describe "PUT #set_black_flag_off" do
    it "sets the black_flag field to false" do
      category = FactoryGirl.create(:category)
      put :set_black_flag_off, {:id => category.to_param}
      category.reload
      expect(category.black_flag?).to be false
    end
    
    it "redirects to the categories index" do
      category = FactoryGirl.create(:category)
      put :set_black_flag_off, {:id => category.to_param}
      category.reload
      expect(response).to redirect_to(categories_url)
    end
  end

end
