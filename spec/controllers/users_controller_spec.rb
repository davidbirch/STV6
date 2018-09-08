# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  email      :string(255)
#  source     :text(65535)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

  describe "GET #index" do
    before :each do
      @user = FactoryGirl.create(:user)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of users" do
      expect(assigns(:users)).to eq([@admin_user,@user])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end  

  describe "GET #show" do
    before :each do
      @user = FactoryGirl.create(:user)
      get :show, params: {id: @user}
    end
        
    it "assigns the requested user to @user" do
      expect(assigns(:user)).to eq(@user)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new User as @user" do
      expect(assigns(:user)).to be_a_new(User)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: FactoryGirl.attributes_for(:valid_user)}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created region as user" do
        post :create, params: {user: FactoryGirl.attributes_for(:valid_user)}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, params: {user: FactoryGirl.attributes_for(:valid_user)}
        expect(response).to redirect_to(User.last)
      end
    end
  end
end
