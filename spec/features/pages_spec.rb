require "rails_helper"

# Useful reference links
# https://github.com/jnicklas/capybara
# https://gist.github.com/428105

# Note: the FQDN tests do not go through the web server because they use
# rack_test instead of selenium/firefox or selenium/chrome (DB)
  
describe "pages: " do
    
  describe "contact page" do
    it "should exist" do
      visit contact_path
      expect(page).to have_content("Contact Page")
      expect(page.status_code).to be(200)
    end
  end
  
  describe "privacy page" do
    it "should exist" do
      visit privacy_path
      expect(page).to have_content("Privacy Policy")
      expect(page.status_code).to be(200)
    end
  end

  
  describe "dashboard page" do
    it "should exist when authenticated" do
      mock_auth_hash
      visit signin_path
      User.first.assign_admin
      visit dashboard_path
      expect(page).to have_content("Dashboard")
      expect(page.status_code).to be(200)
    end
    
    it "should return an error when not authenticated" do
      visit dashboard_path
      expect(page).to have_content("You need to sign in for access to this page.")
      expect(page.status_code).to be(200)
    end
  end

end