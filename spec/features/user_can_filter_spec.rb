require 'rails_helper'

describe "as an authenticated user", :js => :true do
  context "when I visit the root path" do
    it "can filter the results" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: true)
      link = user.links.create(title: "ASDF", url: "https://www.asdf.com", read: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      fill_in "link[title]", with: "asdf"

      within('#links-list') do
        expect(page).to have_content("asdf")
      end
    end

    it "can filter by unread" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: true)
      link = user.links.create(title: "ASDF", url: "https://www.asdf.com", read: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click_on "Only Unread Links"

      within('#links-list') do
        expect(page).to have_content("ASDF")
        expect(page).not_to have_content("Test")
      end
    end

    it "can filter by read" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: true)
      link = user.links.create(title: "ASDF", url: "https://www.asdf.com", read: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      click_on "Only Read Links"

      within('#links-list') do
        expect(page).not_to have_content("ASDF")
        expect(page).to have_content("Test")
      end
    end
  end
end
