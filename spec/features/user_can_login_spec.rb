require 'rails_helper'

describe "as a unauthenticated user" do
  context "when I visit the root path" do
    it "shows me a login form" do
      visit root_path
      expect(page).to have_content("Sign Up")

      click_link("Sign Up")
      expect(current_path).to eq(signup_path)

      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password confirmation")
    end

    it "cannot let me create an account without an email" do
      visit signup_path

      fill_in "Password", with: "asdf"
      fill_in "Password confirmation", with: "asdf"
      click_on "Create User"

      expect(page).to have_content("Email can't be blank")
    end

    it "cannot let me create an account with an existing email" do
      user = User.create(email: "test@test.com", password: "test")

      visit signup_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "asdf"
      fill_in "Password confirmation", with: "asdf"
      click_on "Create User"

      expect(page).to have_content("Email has already been taken")
    end

    it "password and confirmation must match" do
      visit signup_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "asdf"
      fill_in "Password confirmation", with: "asdf2"
      click_on "Create User"

      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "redirects me after creating an account" do
      visit signup_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "asdf"
      fill_in "Password confirmation", with: "asdf"
      click_on "Create User"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("User successfully created")
    end
  end

  context "when I login" do
    it "redirects me to index" do
      user = User.create(email: "test@test.com", password: "test")

      visit login_path

      fill_in "Email", with: "test@test.com"
      fill_in "Password", with: "test"
      click_on "Login"

      expect(page).to have_content("Login Successful")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logout")
    end
  end
end
