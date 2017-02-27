require 'rails_helper'

describe "as an authenticated user" do
  context "when I logout" do
    it "shows me a login or sign up link" do
      user = User.create(email: "test@test.com", password: "test")

      visit login_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "test"
      click_on "Login"

      click_on "Logout"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Sign Up or Login")
    end
  end
end
