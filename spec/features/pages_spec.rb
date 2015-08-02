require "rails_helper"

# Useful reference links
# https://github.com/jnicklas/capybara
# https://gist.github.com/428105

# Note: the FQDN tests do not go through the web server because they use
# rack_test instead of selenium/firefox or selenium/chrome (DB)
  
describe "pages: " do
  
  describe "home page" do
    it "should exist" do
      visit root_path
      expect(page.status_code).to be(200)
    end
    
    it "should link to the about page when authenticated" do
      mock_auth_hash
      visit root_path
      click_link "Sign in with Twitter"
      click_link "About"
      expect(page).to have_content("The About Page")
      expect(page.status_code).to be(200)  
    end

  end
  
  describe "about page" do
    it "should exist when authenticated" do
      visit root_path
      click_link "Sign in with Twitter"
      visit about_path
      expect(page).to have_content("The About Page")
      expect(page.status_code).to be(200)
    end
    
    it "should return an error when not authenticated" do
      visit about_path
      expect(page).to have_content("You need to sign in for access to this page.")
      expect(page.status_code).to be(200)
    end
    
    it "should link back to the home page when authenticated" do
      visit root_path
      mock_auth_hash
      click_link "Sign in with Twitter"
      visit about_path
      click_link('Home')
      expect(page).to have_content("The Home Page")
      expect(page.status_code).to be(200)  
    end
  end

end