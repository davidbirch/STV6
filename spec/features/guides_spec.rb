require "rails_helper"
  
describe "guide: " do
  
  before(:each) do    
    # Create test data
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
  
  describe "navigate to the root page" do
    it "should display the guide index page" do
      visit root_path
      expect(page).to have_content("Melbourne")
      expect(page).to have_content("Brisbane")
      expect(page.status_code).to be(200)  
    end   
  end
  
  describe "navigate to the guide page" do
    it "should display the guide show page for the selected region" do
      visit root_path
      within('ul.nav') {click_link(@region_melbourne.name)}
          
      expect(page).to have_content("Region:")
      expect(page).to have_content("Sport:")
      expect(page).to have_content("Search:")
      expect(page).to have_content(@program.local_start_date_display.to_time.strftime("%A, %e %b %y"))
      expect(page.status_code).to be(200)  
    end   
  end
  
end