require "rails_helper"
  
describe "broadcast services: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create a sport
    @region_melbourne = FactoryGirl.create(:region_melbourne)
    @region_brisbane = FactoryGirl.create(:region_brisbane)
    @channel_seven = FactoryGirl.create(:channel_seven)
    @channel_nine = FactoryGirl.create(:channel_nine)
  end
  
  describe "navigate to the broadcast service page" do
    it "should display the broadcast service page" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Services')} 
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Broadcast Services")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a keyword" do
    it "should create and display a new keyword" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Services')}
      click_link('New')
      select('Melbourne', :from => 'broadcast_service[region_id]')
      select('Seven', :from => 'broadcast_service[channel_id]')
      click_button('Save')
      
      expect(page).to have_content("Broadcast Service was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new broadcast service" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Service')}
      click_link('New')
      select('Melbourne', :from => 'broadcast_service[region_id]')
      select('Seven', :from => 'broadcast_service[channel_id]')
      click_button('Save')
      click_link('Edit')
      select('Brisbane', :from => 'broadcast_service[region_id]')
      select('Nine', :from => 'broadcast_service[channel_id]')
      click_button('Save')
      
      expect(page).to have_content("Broadcast Service was successfully updated.")
      expect(page.status_code).to be(200)
    end
        
    it "should create, delete, and display the broadcast services page" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Services')}
      click_link('New')
      select('Melbourne', :from => 'broadcast_service[region_id]')
      select('Seven', :from => 'broadcast_service[channel_id]')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Broadcast Service was successfully destroyed.")
      expect(page).to have_content("Broadcast Services")
      expect(page.status_code).to be(200)
    end  
  end
end