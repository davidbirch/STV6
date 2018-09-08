require "rails_helper"
  
describe "broadcast events: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    # Create some data
    @region_adelaide = FactoryGirl.create(:region_adelaide) # Adelaide
    @region_hobart = FactoryGirl.create(:region_hobart) # Hobart
    @provider = FactoryGirl.create(:freeview_provider) # Freeview
    @raw_channel_1 = FactoryGirl.create(:raw_channel_including_hash)
    @channel_1 = Channel.create_from_raw_channel(@raw_channel_1) # Adelaide / NIA / Channel Nine Adelaide / 20480
    @broadcast_service_1 = BroadcastService.create_from_raw_channel(@raw_channel_1) 
    @raw_channel_2 = FactoryGirl.create(:raw_channel)
    @channel_2 = Channel.create_from_raw_channel(@raw_channel_2) # Hobart / TST / Test Channel / 12345
    @broadcast_service_2 = BroadcastService.create_from_raw_channel(@raw_channel_2) 

      
    ["Cricket", "Golf", "Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
      FactoryGirl.create(:sport, name: e)
      }
    ["Cricket", "Golf", "Tennis","Rugby League","Soccer","Rugby Union","Other Sport"].each {|e|
      FactoryGirl.create(:keyword, value: e, sport_id: Sport.find_by_name(e).id)
      }        
    @raw_program = FactoryGirl.create(:raw_program_including_hash) # Adelaide / NIA / Golf: The Players: 2008 Garcia
    @program = Program.create_from_raw_program(@raw_program) # Golf: The Players: 2008 Garcia    
  end
  
  describe "navigate to the broadcast events page" do
    it "should display the broadcast events page" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Events')} 
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Broadcast Events")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a keyword" do
    it "should create and display a new keyword" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Events')}
      click_link('New')
      select(@program.id, :from => 'broadcast_event[program_id]')
      select(@broadcast_service_1.id, :from => 'broadcast_event[broadcast_service_id]')
      fill_in('broadcast_event[epoch_scheduled_date]', :with => '1496194200')
      click_button('Save')
      
      expect(page).to have_content("Broadcast Event was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new broadcast event" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Event')}
      click_link('New')
      select(@program.id, :from => 'broadcast_event[program_id]')
      select(@broadcast_service_1.id, :from => 'broadcast_event[broadcast_service_id]')
      fill_in('broadcast_event[epoch_scheduled_date]', :with => '1496194200')
      click_button('Save')
      click_link('Edit')
      select(@broadcast_service_2.id, :from => 'broadcast_event[broadcast_service_id]')
      click_button('Save')
      
      expect(page).to have_content("Broadcast Event was successfully updated.")
      expect(page.status_code).to be(200)
    end
        
    it "should create, delete, and display the broadcast events page" do
      within('ul#nav-broadcast-guide') {click_link('Broadcast Events')}
      click_link('New')
      select(@program.id, :from => 'broadcast_event[program_id]')
      select(@broadcast_service_1.id, :from => 'broadcast_event[broadcast_service_id]')
      fill_in('broadcast_event[epoch_scheduled_date]', :with => '1496194200')
      click_button('Save')
      click_link('Delete')
      
      expect(page).to have_content("Broadcast Event was successfully destroyed.")
      expect(page).to have_content("Broadcast Events")
      expect(page.status_code).to be(200)
    end  
  end
end