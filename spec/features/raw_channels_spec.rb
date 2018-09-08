require "rails_helper"
  
describe "raw-channels: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    @raw_channel = FactoryGirl.create(:raw_channel)
    
  end
  
  describe "navigate to the raw-channels page" do
    it "should display the raw-channels page" do
      within('ul#nav-importer') {click_link('Raw Channels')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Raw Channels")
      expect(page.status_code).to be(200)  
    end   
  end
  
  describe "navigate to the raw-channels show page" do
    it "should display the show raw-channel page" do
      within('ul#nav-importer') {click_link('Raw Channels')}
      click_link(@raw_channel.id)
      
      expect(page).to have_content("Raw Channel")
      expect(page.status_code).to be(200)  
    end   
  end
  
  

end