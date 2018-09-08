require "rails_helper"
  
describe "channels: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create a provider
    @provider = FactoryGirl.create(:freeview_provider)
  end
  
  describe "navigate to the channels page" do
    it "should display the channels page" do
      within('ul#nav-reference') {click_link('All Channels')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Channels")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a region" do
    it "should create and display a new channel" do
      within('ul#nav-reference') {click_link('All Channels')}
      click_link('New')
      fill_in('channel[name]', :with => 'Seven')
      fill_in('channel[short_name]', :with => 'Seve')
      fill_in('channel[tag]', :with => 'SVN')
      check('channel[black_flag]')
      fill_in('channel[default_sport]', :with => 'AFL')
      select('Freeview', :from => 'channel[provider_id]')
      click_button('Save')
      
      expect(page).to have_content("Channel was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new channel" do
      within('ul#nav-reference') {click_link('All Channels')}
      click_link('New')
      fill_in('channel[name]', :with => 'Seven')
      fill_in('channel[short_name]', :with => 'Sev')
      fill_in('channel[tag]', :with => 'SVN')
      check('channel[black_flag]')
      fill_in('channel[default_sport]', :with => 'AFL')
      select('Freeview', :from => 'channel[provider_id]')
      click_button('Save')
      click_link('Edit')
      fill_in('channel[name]', :with => 'Nine')
      fill_in('channel[short_name]', :with => 'Nin')
      uncheck('channel[black_flag]') 
      click_button('Save')
      
      expect(page).to have_content("Channel was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the Channels page" do
      within('ul#nav-reference') {click_link('All Channels')}
      click_link('New')
      fill_in('channel[name]', :with => 'Seven')
      fill_in('channel[short_name]', :with => 'Sev')
      fill_in('channel[tag]', :with => 'SVN')
      check('channel[black_flag]')
      fill_in('channel[default_sport]', :with => 'AFL')
      select('Freeview', :from => 'channel[provider_id]')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Channel was successfully destroyed.")
      expect(page).to have_content("Channels")
      expect(page.status_code).to be(200)
    end  
  end
end