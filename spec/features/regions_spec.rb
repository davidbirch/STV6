require "rails_helper"
  
describe "regions: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the regions page" do
    it "should display the regions page" do
      within('ul#nav-reference') {click_link('Regions')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Regions")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a region" do
    it "should create and display a new region" do
      within('ul#nav-reference') {click_link('Regions')}
      click_link('New')
      fill_in('region[name]', :with => 'Hobart')
      click_button('Save')
      
      expect(page).to have_content("Region was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new region" do
      within('ul#nav-reference') {click_link('Regions')}
      click_link('New')
      fill_in('region[name]', :with => 'Hobart')
      click_button('Save')
      click_link('Edit')
      fill_in('region[name]', :with => 'Canberra')
      click_button('Save')
      
      expect(page).to have_content("Region was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the regions page" do
      within('ul#nav-reference') {click_link('Regions')}
      click_link('New')
      fill_in('region[name]', :with => 'Hobart')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Region was successfully destroyed.")
      expect(page).to have_content("Regions")
      expect(page.status_code).to be(200)
    end  
  end
end