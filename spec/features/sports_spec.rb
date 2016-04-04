require "rails_helper"
  
describe "sports: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the sports page" do
    it "should display the sports page" do
      within('ul#nav-reference') {click_link('Sports')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Sports")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a sport" do
    it "should create and display a new sport" do
      within('ul#nav-reference') {click_link('Sports')}
      click_link('New')
      fill_in('sport[name]', :with => 'Chess')
      click_button('Save')
      
      expect(page).to have_content("Sport was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new sport" do
      within('ul#nav-reference') {click_link('Sport')}
      click_link('New')
      fill_in('sport[name]', :with => 'Chess')
      click_button('Save')
      click_link('Edit')
      fill_in('sport[name]', :with => 'Draughts')
      click_button('Save')
      
      expect(page).to have_content("Sport was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the sports page" do
      within('ul#nav-reference') {click_link('Sports')}
      click_link('New')
      fill_in('sport[name]', :with => 'Chess')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Sport was successfully destroyed.")
      expect(page).to have_content("Sports")
      expect(page.status_code).to be(200)
    end  
  end
end