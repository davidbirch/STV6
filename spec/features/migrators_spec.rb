require "rails_helper"
  
describe "migrators: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the migrators page" do
    it "should display the migrators page" do
      within('ul#nav-importer') {click_link('Migrators')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Migrators")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a migrator" do
    it "should create and display a new migrator" do
      within('ul#nav-importer') {click_link('Migrators')}
      click_link('New')
      fill_in('migrator[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      
      expect(page).to have_content("Migrator was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new category" do
      within('ul#nav-importer') {click_link('Migrators')}
      click_link('New')
      fill_in('migrator[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Edit')
      fill_in('migrator[target_region_list]', :with => '["Adelaide", "Brisbane"]') 
      click_button('Save')
      
      expect(page).to have_content("Migrator was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Categories page" do
      within('ul#nav-importer') {click_link('Migrators')}
      click_link('New')
      fill_in('migrator[target_region_list]', :with => '["Adelaide"]') 
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Migrator was successfully destroyed.")
      expect(page).to have_content("Migrators")
      expect(page.status_code).to be(200)
    end  
  end
end