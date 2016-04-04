# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  url_friendly_value :string(255)
#  sport_id           :integer
#  priority           :integer
#  black_flag         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe KeywordsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @keyword = FactoryGirl.create(:keyword)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of keywords" do
      expect(assigns(:keywords)).to eq([@keyword])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @keyword = FactoryGirl.create(:keyword)
      get :show, id: @keyword
    end
        
    it "assigns the requested keyword to @keyword" do
      expect(assigns(:keyword)).to eq(@keyword)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Keyword as @keyword" do
      expect(assigns(:keyword)).to be_a_new(Keyword)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Keyword" do
        expect {
          post :create, keyword: FactoryGirl.attributes_for(:keyword)
        }.to change(Keyword.unscoped, :count).by(1)
      end

      it "assigns a newly created keyword as @keyword" do
        post :create, keyword: FactoryGirl.attributes_for(:keyword)
        expect(assigns(:keyword)).to be_a(Keyword)
        expect(assigns(:keyword)).to be_persisted
      end

      it "redirects to the created keyword" do
        post :create, keyword: FactoryGirl.attributes_for(:keyword)
        expect(response).to redirect_to(Keyword.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved keyword as @keyword" do
        post :create, keyword: FactoryGirl.attributes_for(:invalid_keyword)
        expect(assigns(:keyword)).to be_a_new(Keyword)
      end

      it "re-renders the 'new' template" do
        post :create, keyword: FactoryGirl.attributes_for(:invalid_keyword)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested keyword as @keyword" do
        keyword = FactoryGirl.create(:keyword)
        put :update, {:id => keyword.to_param, :keyword => FactoryGirl.attributes_for(:ashes_keyword)}
        expect(assigns(:keyword)).to eq(keyword)
      end

      it "redirects to the keyword" do
        keyword = FactoryGirl.create(:keyword)
        put :update, {:id => keyword.to_param, :keyword => FactoryGirl.attributes_for(:ashes_keyword)}
        keyword.reload
        expect(response).to redirect_to(keyword)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        keyword = FactoryGirl.create(:keyword)
        put :update, {:id => keyword.to_param, :keyword => FactoryGirl.attributes_for(:invalid_keyword)}
        expect(assigns(:keyword)).to eq(keyword)
      end

      it "re-renders the 'edit' template" do
        keyword = FactoryGirl.create(:keyword)
        put :update, {:id => keyword.to_param, :keyword => FactoryGirl.attributes_for(:invalid_keyword)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested keyword" do
      keyword = FactoryGirl.create(:keyword)
      expect {
        delete :destroy, {:id => keyword.to_param}
      }.to change(Keyword.unscoped, :count).by(-1)
    end

    it "redirects to the keywords list" do
      keyword = FactoryGirl.create(:keyword)
      delete :destroy, {:id => keyword.to_param}
      expect(response).to redirect_to(keywords_url)
    end
  end
  
  describe "PUT #set_black_flag_on" do
    it "sets the black_flag field to true" do
      keyword = FactoryGirl.create(:keyword)
      put :set_black_flag_on, {:id => keyword.to_param}
      keyword.reload
      expect(keyword.black_flag?).to be true
    end
    
    it "redirects to the keywords index" do
      keyword = FactoryGirl.create(:keyword)
      put :set_black_flag_on, {:id => keyword.to_param}
      keyword.reload
      expect(response).to redirect_to(keywords_url)
    end
  end
  
  describe "PUT #set_black_flag_off" do
    it "sets the black_flag field to false" do
      keyword = FactoryGirl.create(:keyword)
      put :set_black_flag_off, {:id => keyword.to_param}
      keyword.reload
      expect(keyword.black_flag?).to be false
    end
    
    it "redirects to the keywords index" do
      keyword = FactoryGirl.create(:keyword)
      put :set_black_flag_off, {:id => keyword.to_param}
      keyword.reload
      expect(response).to redirect_to(keywords_url)
    end
  end

end
