require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:valid_user)
    session[:user_id] = @user.id
  end

  describe "GET #index" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :index
    end
      
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of programs" do
      expect(assigns(:programs)).to eq([@program])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end  

  describe "GET #show" do
    before :each do
      @program = FactoryGirl.create(:program)
      get :show, id: @program
    end
        
    it "assigns the requested program to @program" do
      expect(assigns(:program)).to eq(@program)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new Program as @program" do
      expect(assigns(:program)).to be_a_new(Program)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before :each do
        @region = FactoryGirl.create(:region)
        @sport = FactoryGirl.create(:sport)
        @channel = FactoryGirl.create(:channel)
        @keyword = FactoryGirl.create(:keyword)
      end
      
      it "creates a new Program" do
        expect {
          post :create, program: FactoryGirl.attributes_for(:program, region_id: @region.id, sport_id: @sport.id, channel_id: @channel.id, keyword_id: @keyword.id)
        }.to change(Program, :count).by(1)
      end

      it "assigns a newly created program as @program" do
        post :create, program: FactoryGirl.attributes_for(:program, region_id: @region.id, sport_id: @sport.id, channel_id: @channel.id, keyword_id: @keyword.id)
        expect(assigns(:program)).to be_a(Program)
        expect(assigns(:program)).to be_persisted
      end

      it "redirects to the created program" do
        post :create, program: FactoryGirl.attributes_for(:program, region_id: @region.id, sport_id: @sport.id, channel_id: @channel.id, keyword_id: @keyword.id)
        expect(response).to redirect_to(Program.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved program as @program" do
        post :create, program: FactoryGirl.attributes_for(:invalid_program)
        expect(assigns(:program)).to be_a_new(Program)
      end

      it "re-renders the 'new' template" do
        post :create, program: FactoryGirl.attributes_for(:invalid_program)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested program as @program" do
        program = FactoryGirl.create(:program)
        put :update, {:id => program.to_param, :program => FactoryGirl.attributes_for(:valid_program)}
        expect(assigns(:program)).to eq(program)
      end

      it "redirects to the program" do
        program = FactoryGirl.create(:program)
        put :update, {:id => program.to_param, :program => FactoryGirl.attributes_for(:valid_program)}
        expect(response).to redirect_to(program)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        program = FactoryGirl.create(:program)
        put :update, {:id => program.to_param, :program => FactoryGirl.attributes_for(:invalid_program)}
        expect(assigns(:program)).to eq(program)
      end

      it "re-renders the 'edit' template" do
        program = FactoryGirl.create(:program)
        put :update, {:id => program.to_param, :program => FactoryGirl.attributes_for(:invalid_program)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested program" do
      program = FactoryGirl.create(:program)
      expect {
        delete :destroy, {:id => program.to_param}
      }.to change(Program, :count).by(-1)
    end

    it "redirects to the programs list" do
      program = FactoryGirl.create(:program)
      delete :destroy, {:id => program.to_param}
      expect(response).to redirect_to(programs_url)
    end
  end

end
