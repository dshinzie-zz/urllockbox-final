require 'rails_helper'

describe "as an authenticated user", :js => :true do
  context "when I visit the root path" do
    it "shows me a form to create a link" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_content("Url")
      expect(page).to have_content("Title")
    end

    it "can create a new link" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      fill_in "link[url]", with: "Turing"
      fill_in "link[title]", with: "http://turing.io"
      click_on "Create Link"

      within('#links-list') do
        expect(page).to have_content(user.links.first.url)
        expect(page).to have_content(user.links.first.title)
      end
    end

    it "cannot let me create a link without a url" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      fill_in "link[url]", with: ""
      fill_in "link[title]", with: "https://www.google.com"
      click_on "Create Link"

      expect(page).to have_content("Invalid Link")
    end

    it "cannot let me create a link without a valid url" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in "link[url]", with: "google.com"
      fill_in "link[title]", with: "https://www.google.com"

      click_on "Create Link"

      expect(page).to have_content("Invalid Link")
    end

    it "cannot let me create a link without a title" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in "link[url]", with: "https://www.google.com"
      click_on "Create Link"

      expect(page).to have_content("Title can't be blank")
    end

    it "cannot let me create a link without a url" do
      user = User.create(email: "test@test.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      fill_in "link[title]", with: "Test"
      click_on "Create Link"

      expect(page).to have_content("Invalid Link")
    end

  end
end
