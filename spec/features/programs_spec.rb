require "rails_helper"
  
describe "programs: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create a keyword
    @keyword = FactoryGirl.create(:cricket_keyword)
  end
  
  describe "navigate to the programs page" do
    it "should display the programs page" do
      within('ul#nav-reference') {click_link('All Programs')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Programs")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a program" do
    it "should create and display a new program" do
      within('ul#nav-reference') {click_link('All Programs')}
      click_link('New')
      fill_in('program[title]', :with => 'A Program')
      fill_in('program[episode_title]', :with => 'Episode 1')
      fill_in('program[duration]', :with => '60')
      check('program[black_flag]')
      select('Cricket', :from => 'program[keyword_id]')     
      click_button('Save')
      
      expect(page).to have_content("Program was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new program" do
      within('ul#nav-reference') {click_link('All Program')}
      click_link('New')
      fill_in('program[title]', :with => 'A Program')
      fill_in('program[episode_title]', :with => 'Episode 1')
      fill_in('program[duration]', :with => '60')
      check('program[black_flag]')
      select('Cricket', :from => 'program[keyword_id]')     
      click_button('Save')
      click_link('Edit')
      fill_in('program[title]', :with => 'Something Else')
      fill_in('program[duration]', :with => '30')
      uncheck('program[black_flag]')
      click_button('Save')
      
      expect(page).to have_content("Program was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the programs page" do
      within('ul#nav-reference') {click_link('All Programs')}
      click_link('New')
      fill_in('program[title]', :with => 'A Program')
      fill_in('program[episode_title]', :with => 'Episode 1')
      fill_in('program[duration]', :with => '60')
      check('program[black_flag]')
      select('Cricket', :from => 'program[keyword_id]')     
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Program was successfully destroyed.")
      expect(page).to have_content("Programs")
      expect(page.status_code).to be(200)
    end  
  end
end