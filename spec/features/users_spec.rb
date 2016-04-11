require "rails_helper"
  
describe "users: " do
  
  describe "login as a valid user" do
    it "should link to the show user page" do
      mock_auth_hash
      visit signin_path
      click_link('View details')
      expect(page).to have_content("Signed in as mockuser")
      expect(page.status_code).to be(200)  
    end
    
    it "should not link to the user index page" do
      mock_auth_hash
      visit signin_path
      expect(page).to have_link("View details")
      expect(page).to have_no_link("Users", :href=>"/users")
      expect(page.status_code).to be(200)  
    end
  end

end