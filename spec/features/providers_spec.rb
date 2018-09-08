require "rails_helper"
  
describe "providers: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the providers page" do
    it "should display the providers page" do
      within('ul#nav-reference') {click_link('Providers')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Providers")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a provider" do
    it "should create and display a new provider" do
      within('ul#nav-reference') {click_link('Providers')}
      click_link('New')
      fill_in('provider[name]', :with => 'Freeview')
      fill_in('provider[service_tier]', :with => 'Free')
      click_button('Save')
      
      expect(page).to have_content("Provider was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new provider" do
      within('ul#nav-reference') {click_link('Provider')}
      click_link('New')
      fill_in('provider[name]', :with => 'Another')
      fill_in('provider[service_tier]', :with => 'Free')
      click_button('Save')
      click_link('Edit')
      fill_in('provider[name]', :with => 'Something Else')
      click_button('Save')
      
      expect(page).to have_content("Provider was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the providers page" do
      within('ul#nav-reference') {click_link('Providers')}
      click_link('New')
      fill_in('provider[name]', :with => 'Freeview')
      fill_in('provider[service_tier]', :with => 'Free')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Provider was successfully destroyed.")
      expect(page).to have_content("Providers")
      expect(page.status_code).to be(200)
    end  
  end
end