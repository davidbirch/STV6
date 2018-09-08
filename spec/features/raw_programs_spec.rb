require "rails_helper"
  
describe "raw-programs: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    @raw_program = FactoryGirl.create(:raw_program)
    
  end
  
  describe "navigate to the raw-programs page" do
    it "should display the raw-programs page" do
      within('ul#nav-importer') {click_link('Raw Programs')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Raw Programs")
      expect(page.status_code).to be(200)  
    end   
  end
  
  describe "navigate to the raw-programs show page" do
    it "should display the show raw-program page" do
      within('ul#nav-importer') {click_link('Raw Programs')}
      click_link(@raw_program.id)
      
      expect(page).to have_content("Raw Program")
      expect(page.status_code).to be(200)  
    end   
  end
  
  

end