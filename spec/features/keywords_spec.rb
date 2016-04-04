require "rails_helper"
  
describe "keywords: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create a sport
    @sport = FactoryGirl.create(:cricket_sport)
  end
  
  describe "navigate to the keywords page" do
    it "should display the keywords page" do
      within('ul#nav-reference') {click_link('Keywords')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Keywords")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a keyword" do
    it "should create and display a new keyword" do
      within('ul#nav-reference') {click_link('Keywords')}
      click_link('New')
      fill_in('keyword[value]', :with => 'ODI')
      fill_in('keyword[priority]', :with => '10')
      check('keyword[black_flag]')
      select('Cricket', :from => 'keyword[sport_id]')
      click_button('Save')
      
      expect(page).to have_content("Keyword was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new keyword" do
      within('ul#nav-reference') {click_link('Keyword')}
      click_link('New')
      fill_in('keyword[value]', :with => 'ODI')
      fill_in('keyword[priority]', :with => '10')
      check('keyword[black_flag]')
      select('Cricket', :from => 'keyword[sport_id]')
      click_button('Save')
      click_link('Edit')
      fill_in('keyword[value]', :with => 'Test Match')
      uncheck('keyword[black_flag]')
      click_button('Save')
      
      expect(page).to have_content("Keyword was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new keyword" do
      within('ul#nav-reference') {click_link('Keyword')}
      click_link('New')
      fill_in('keyword[value]', :with => 'ODI')
      fill_in('keyword[priority]', :with => '10')
      check('keyword[black_flag]')
      select('Cricket', :from => 'keyword[sport_id]')
      click_button('Save')
      click_link('Edit')
      uncheck('keyword[black_flag]')
      click_button('Save')
      
      expect(page).to have_content("Keyword was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the keywords page" do
      within('ul#nav-reference') {click_link('Keywords')}
      click_link('New')
      fill_in('keyword[value]', :with => 'ODI')
      fill_in('keyword[priority]', :with => '10')
      check('keyword[black_flag]')
      select('Cricket', :from => 'keyword[sport_id]')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Keyword was successfully destroyed.")
      expect(page).to have_content("Keywords")
      expect(page.status_code).to be(200)
    end  
  end
end