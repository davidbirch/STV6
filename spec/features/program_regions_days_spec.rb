require "rails_helper"
  
describe "programs-by-region-and-day: " do
  
  before(:each) do
    # login as a user with admin privilege
    mock_auth_hash
    visit signin_path
    @user = User.first
    @user.assign_admin
    visit root_path
    
    @sport_cricket = FactoryGirl.create(:cricket_sport)
    @sport_tennis = FactoryGirl.create(:tennis_sport)
    @channel_nine = FactoryGirl.create(:channel_nine)
    @channel_seven = FactoryGirl.create(:channel_seven)
    @region_melbourne = FactoryGirl.create(:region_melbourne)
    @region_brisbane = FactoryGirl.create(:region_brisbane)
    @keyword = FactoryGirl.create(:keyword)
    @category = FactoryGirl.create(:sport_category)
      
    @program = FactoryGirl.create(:valid_program, channel_id: @channel_nine.id, region_id: @region_melbourne.id, sport_id: @sport_cricket.id, keyword_id: @keyword.id, category_id: @category.id)
                                     
  end
  
  describe "navigate to the programs-by-region-and-day page" do
    it "should display the programs-by-region-and-day page" do
      within('ul#nav-guide') {click_link('By Region And Day')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("By Region And Day")
      expect(page.status_code).to be(200)  
    end   
  end
  
  describe "navigate to the programs-by-day show page" do
    it "should display the show day page" do
      within('ul#nav-guide') {click_link('By Day')}  
      click_link(@program.start_datetime.strftime('%a %d %b %Y'))
      
      expect(page).to have_content("Day: #{@program.start_date_display}")
      expect(page).to have_content("Programs")
      expect(page.status_code).to be(200)  
    end   
  end
  
  

end