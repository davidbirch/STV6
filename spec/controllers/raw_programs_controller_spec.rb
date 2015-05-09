require 'rails_helper'

RSpec.describe RawProgramsController, type: :controller do

  describe "GET #index" do
    before :each do
      @raw_program = FactoryGirl.create(:raw_program)
      get :index
    end
    
    it "should return a 200 status" do
      expect(response.status).to eq 200
    end
    
    it "populates an array of raw_programs" do
      expect(assigns(:raw_programs)).to eq([@raw_program])
    end
    
    it "renders the :index view" do
      expect(response).to render_template :index
    end
    
  end

  describe "GET #show" do
    before :each do
      @raw_program = FactoryGirl.create(:raw_program)
      get :show, id: @raw_program
    end
        
    it "assigns the requested raw_program to @raw_program" do
      expect(assigns(:raw_program)).to eq(@raw_program)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
  
  describe "GET #new" do
    before :each do
      get :new
    end
      
    it "assigns a new RawProgram as @raw_program" do
      expect(assigns(:raw_program)).to be_a_new(RawProgram)
    end
    
    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RawProgram" do
        expect {
          post :create, raw_program: FactoryGirl.attributes_for(:raw_program)
        }.to change(RawProgram, :count).by(1)
      end

      it "assigns a newly created raw_program as @raw_program" do
        post :create, raw_program: FactoryGirl.attributes_for(:raw_program)
        expect(assigns(:raw_program)).to be_a(RawProgram)
        expect(assigns(:raw_program)).to be_persisted
      end

      it "redirects to the created raw_program" do
        post :create, raw_program: FactoryGirl.attributes_for(:raw_program)
        expect(response).to redirect_to(RawProgram.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved raw_program as @raw_program" do
        post :create, raw_program: FactoryGirl.attributes_for(:invalid_raw_program)
        expect(assigns(:raw_program)).to be_a_new(RawProgram)
      end

      it "re-renders the 'new' template" do
        post :create, raw_program: FactoryGirl.attributes_for(:invalid_raw_program)
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT #update" do
    context "with valid params" do

      it "assigns the requested raw_program as @raw_program" do
        raw_program = FactoryGirl.create(:raw_program)
        put :update, {:id => raw_program.to_param, :raw_program => FactoryGirl.attributes_for(:tennis_raw_program)}
        expect(assigns(:raw_program)).to eq(raw_program)
      end

      it "redirects to the raw_program" do
        raw_program = FactoryGirl.create(:raw_program)
        put :update, {:id => raw_program.to_param, :raw_program => FactoryGirl.attributes_for(:tennis_raw_program)}
        expect(response).to redirect_to(raw_program)
      end
    end

    context "with invalid params" do
      it "assigns the raw_program as @raw_program" do
        raw_program = FactoryGirl.create(:raw_program)
        put :update, {:id => raw_program.to_param, :raw_program => FactoryGirl.attributes_for(:invalid_raw_program)}
        expect(assigns(:raw_program)).to eq(raw_program)
      end

      it "re-renders the 'edit' template" do
        raw_program = FactoryGirl.create(:raw_program)
        put :update, {:id => raw_program.to_param, :raw_program => FactoryGirl.attributes_for(:invalid_raw_program)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested raw_program" do
      raw_program = FactoryGirl.create(:raw_program)
      expect {
        delete :destroy, {:id => raw_program.to_param}
      }.to change(RawProgram, :count).by(-1)
    end

    it "redirects to the raw_programs list" do
      raw_program = FactoryGirl.create(:raw_program)
      delete :destroy, {:id => raw_program.to_param}
      expect(response).to redirect_to(raw_programs_url)
    end
  end

end
