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
    
    it "should link to the about page" do
      visit root_path
      click_link('About')
      expect(page.status_code).to be(200) 
    end
    
  end
  
  describe "about page" do
    it "should exist" do
      visit about_path
      expect(page.status_code).to be(200) 
    end
    
    it "should link back to the home page" do
      visit about_path
      click_link('Home')
      expect(page.status_code).to be(200) 
    end
  end

end