require "rails_helper"
  
describe "programs: " do
  
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
    
    @tomorrow = Date.today + 1
  end
  
  describe "navigate to the programs page" do
    it "should display the programs page" do
      within('ul#nav-guide') {click_link('Programs')}
      
      expect(page).to have_content("Signed in as mockuser")
      expect(page).to have_content("Programs")
      expect(page.status_code).to be(200)  
    end   
  end

  describe "create, save, edit a programs" do
    it "should create and display a new program" do
      within('ul#nav-guide') {click_link('Programs')}
      click_link('New')
      fill_in('program[title]', :with => 'The AFL Grand Final')
      fill_in('program[subtitle]', :with => '2016')
      fill_in('program[description]', :with => 'The program is the AFL Grand Final')
      fill_in('program[program_hash]', :with => '#(A hash of the program)')
      select(@tomorrow.strftime("%Y"), :from => 'program[start_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[start_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[start_datetime(3i)]')
      select('10', :from => 'program[start_datetime(4i)]')
      select('00', :from => 'program[start_datetime(5i)]')
      select(@tomorrow.strftime("%Y"), :from => 'program[end_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[end_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[end_datetime(3i)]')
      select('11', :from => 'program[end_datetime(4i)]')
      select('30', :from => 'program[end_datetime(5i)]')
      select(@region_melbourne.name, :from => 'program[region_id]')
      select(@sport_tennis.name, :from => 'program[sport_id]')
      select(@channel_seven.name, :from => 'program[channel_id]')
      select(@keyword.value, :from => 'program[keyword_id]')
      select(@category.name, :from => 'program[category_id]')
      click_button('Save')
          
      expect(page).to have_content("Program was successfully created.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, edit, and display a new program" do
      within('ul#nav-guide') {click_link('Programs')}
      click_link('New')
      fill_in('program[title]', :with => 'The AFL Grand Final')
      fill_in('program[subtitle]', :with => '2016')
      fill_in('program[description]', :with => 'The program is the AFL Grand Final')
      fill_in('program[program_hash]', :with => '#(A hash of the program)')
      select(@tomorrow.strftime("%Y"), :from => 'program[start_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[start_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[start_datetime(3i)]')
      select('10', :from => 'program[start_datetime(4i)]')
      select('00', :from => 'program[start_datetime(5i)]')
      select(@tomorrow.strftime("%Y"), :from => 'program[end_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[end_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[end_datetime(3i)]')
      select('11', :from => 'program[end_datetime(4i)]')
      select('30', :from => 'program[end_datetime(5i)]')
      select(@region_melbourne.name, :from => 'program[region_id]')
      select(@sport_tennis.name, :from => 'program[sport_id]')
      select(@channel_seven.name, :from => 'program[channel_id]')
      select(@keyword.value, :from => 'program[keyword_id]')
      select(@category.name, :from => 'program[category_id]')
      click_button('Save')
      within('#form-actions') {click_link('Edit')}
      fill_in('program[title]', :with => 'Wimbledon')
      select(@channel_nine.name, :from => 'program[channel_id]')
      click_button('Save')
      
      expect(page).to have_content("Program was successfully updated.")
      expect(page.status_code).to be(200)
    end
    
    it "should create, delete, and display the programs page" do
      within('ul#nav-guide') {click_link('Programs')}
      click_link('New')
      fill_in('program[title]', :with => 'The AFL Grand Final')
      fill_in('program[subtitle]', :with => '2016')
      fill_in('program[description]', :with => 'The program is the AFL Grand Final')
      fill_in('program[program_hash]', :with => '#(A hash of the program)')
      select(@tomorrow.strftime("%Y"), :from => 'program[start_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[start_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[start_datetime(3i)]')
      select('10', :from => 'program[start_datetime(4i)]')
      select('00', :from => 'program[start_datetime(5i)]')
      select(@tomorrow.strftime("%Y"), :from => 'program[end_datetime(1i)]')
      select(@tomorrow.strftime("%B"), :from => 'program[end_datetime(2i)]')
      select(@tomorrow.strftime("%-d"), :from => 'program[end_datetime(3i)]')
      select('11', :from => 'program[end_datetime(4i)]')
      select('30', :from => 'program[end_datetime(5i)]')
      select(@region_melbourne.name, :from => 'program[region_id]')
      select(@sport_tennis.name, :from => 'program[sport_id]')
      select(@channel_seven.name, :from => 'program[channel_id]')
      select(@keyword.value, :from => 'program[keyword_id]')
      select(@category.name, :from => 'program[category_id]')
      click_button('Save')
      within('#form-actions') {click_link('Delete')}
      
      expect(page).to have_content("Program was successfully destroyed.")
      expect(page).to have_content("Programs")
      expect(page.status_code).to be(200)
    end  
  end
end