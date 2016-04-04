require "rails_helper"
  
describe "channels-by-short-name: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create a channel
    @channel = FactoryGirl.create(:channel_seven)
  end
  
  describe "navigate to the channels-by-short-name page" do
    it "should display the channels-by-short-name page" do
      within('ul#nav-guide') {click_link('By Short Name')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Channels By Short Name")
      expect(page.status_code).to be(200)  
    end   
  end
  
  describe "navigate to the channel-short-name page" do
    it "should display the channel-short-name page" do
      within('ul#nav-guide') {click_link('By Short Name')}
      click_link(@channel.short_name)
      
      expect(page).to have_content("Short Name: #{@channel.url_friendly_short_name}")
      expect(page.status_code).to be(200)  
    end   
  end

end