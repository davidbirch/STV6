require "rails_helper"
  
describe "sessions: " do
  
  describe "sign in" do
    
    it "should work for mock credentials" do
      visit root_path
      mock_auth_hash
      visit signin_path
      expect(page).to have_content("Signed in!")
      expect(page).to have_content("mockuser")  # user name
      expect(page).to have_content("Sign out")
    end
    
    it "can handle authentication error" do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      visit signin_path
      expect(page).to have_content("Sorry, could not log you in...")
      expect(page.status_code).to be(200)
    end
  end
  
  describe "sign out" do
    it "should work when visiting the sign out path directly" do
      visit signout_path
      expect(page).to have_content("Signed out!")
      expect(page.status_code).to be(200)
    end
    
    it "should work after sign in" do
      visit root_path
      mock_auth_hash
      visit signin_path
      expect(page).to have_content("Signed in!")
      expect(page).to have_content("mockuser")  # user name
      expect(page).to have_content("Sign out")
      click_link "Sign out"
      expect(page).to have_content("Signed out!")
      expect(page.status_code).to be(200)
    end  
     
  end
  
  describe "auth failure" do
    it "should exist" do
      visit auth_failure_path
      expect(page.status_code).to be(200)
    end
  end
  
end