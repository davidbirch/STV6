# == Schema Information
#
# Table name: raw_programs
#
#  id            :integer          not null, primary key
#  program_hash  :text(65535)
#  channel_tag   :string(255)
#  region_lookup :string(255)
#  region_name   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe RawProgramsController, type: :controller do
  before(:each) do
    @admin_user = FactoryGirl.create(:valid_admin_user)
    session[:user_id] = @admin_user.id
  end

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
      get :show, params:{id: @raw_program}
    end
        
    it "assigns the requested raw_program to @raw_program" do
      expect(assigns(:raw_program)).to eq(@raw_program)
    end
        
    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

end
