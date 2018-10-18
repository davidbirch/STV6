require "rails_helper"
  
describe "linkers: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the linkers page" do
    it "should display the linkers page" do
      within('ul#nav-importer') {click_link('Linkers')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Linkers")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a linker" do
    it "should create and display a new linker" do
      within('ul#nav-importer') {click_link('Linkers')}
      click_link('New')
      #fill_in('linker[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      
      expect(page).to have_content("Linker was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new linker" do
      within('ul#nav-importer') {click_link('Linkers')}
      click_link('New')
      #fill_in('linker[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Edit')
      #fill_in('linker[target_region_list]', :with => '["Adelaide", "Brisbane"]') 
      click_button('Save')
      
      expect(page).to have_content("Linker was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Linkers page" do
      within('ul#nav-importer') {click_link('Linkers')}
      click_link('New')
      #fill_in('linker[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Linker was successfully destroyed.")
      expect(page).to have_content("Linkers")
      expect(page.status_code).to be(200)
    end  
  end
end