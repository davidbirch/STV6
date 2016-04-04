require "rails_helper"
  
describe "categories: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
  end
  
  describe "navigate to the categories page" do
    it "should display the categories page" do
      within('ul#nav-reference') {click_link('Categories')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Categories")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a region" do
    it "should create and display a new category" do
      within('ul#nav-reference') {click_link('Categories')}
      click_link('New')
      fill_in('category[name]', :with => 'Entertainment')
      check('category[black_flag]') 
      click_button('Save')
      
      expect(page).to have_content("Category was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new category" do
      within('ul#nav-reference') {click_link('Categories')}
      click_link('New')
      fill_in('category[name]', :with => 'Entertainment')
      check('category[black_flag]') 
      click_button('Save')
      click_link('Edit')
      fill_in('category[name]', :with => 'Science')
      uncheck('category[black_flag]') 
      click_button('Save')
      
      expect(page).to have_content("Category was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Categories page" do
      within('ul#nav-reference') {click_link('Categories')}
      click_link('New')
      fill_in('category[name]', :with => 'Entertainment')
      check('category[black_flag]') 
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Category was successfully destroyed.")
      expect(page).to have_content("Categories")
      expect(page.status_code).to be(200)
    end  
  end
end