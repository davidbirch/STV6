require "rails_helper"
  
describe "cleaners: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the cleaners page" do
    it "should display the cleaners page" do
      within('ul#nav-importer') {click_link('Cleaners')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Cleaners")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a cleaner" do
    it "should create and display a new cleaner" do
      within('ul#nav-importer') {click_link('Cleaners')}
      click_link('New')
      #fill_in('cleaner[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      
      expect(page).to have_content("Cleaner was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new category" do
      within('ul#nav-importer') {click_link('Cleaners')}
      click_link('New')
      #fill_in('cleaner[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Edit')
      #fill_in('cleaner[target_region_list]', :with => '["Adelaide", "Brisbane"]') 
      click_button('Save')
      
      expect(page).to have_content("Cleaner was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Categories page" do
      within('ul#nav-importer') {click_link('Cleaners')}
      click_link('New')
      #fill_in('cleaner[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Cleaner was successfully destroyed.")
      expect(page).to have_content("Cleaners")
      expect(page.status_code).to be(200)
    end  
  end
end