require "rails_helper"
  
describe "scrapers: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the scrapers page" do
    it "should display the scrapers page" do
      within('ul#nav-importer') {click_link('Scrapers')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Scrapers")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a scraper" do
    it "should create and display a new scraper" do
      within('ul#nav-importer') {click_link('Scrapers')}
      click_link('New')
      fill_in('scraper[days_to_gather]', :with => '1')
      fill_in('scraper[target_region_list]', :with => '[["Adelaide", "81"]]') 
      click_button('Save')
      
      expect(page).to have_content("Scraper was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new scraper" do
      within('ul#nav-importer') {click_link('Scrapers')}
      click_link('New')
      fill_in('scraper[days_to_gather]', :with => '1')
      fill_in('scraper[target_region_list]', :with => '[["Adelaide", "81"]]') 
      click_button('Save')
      click_link('Edit')
      fill_in('scraper[days_to_gather]', :with => '2')
      click_button('Save')
      
      expect(page).to have_content("Scraper was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Scrapers page" do
      within('ul#nav-importer') {click_link('Scrapers')}
      click_link('New')
      fill_in('scraper[days_to_gather]', :with => '1')
      fill_in('scraper[target_region_list]', :with => '[["Adelaide", "81"]]') 
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Scraper was successfully destroyed.")
      expect(page).to have_content("Scrapers")
      expect(page.status_code).to be(200)
    end  
  end
end