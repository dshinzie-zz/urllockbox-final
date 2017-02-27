require 'rails_helper'

describe "as an authenticated user", :js => :true do
  context "when I visit the root path" do
    it "can edit a links title" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: "read")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      click_on "Edit"
      find(".link-title").set("http://turing.io")
      click_on "Save"

      within('#links-list') do
        expect(page).to have_content("test")
        expect(page).to have_content("http://turing.io")
      end
    end

    it "does not save with an empty title" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: "read")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      click_on "Edit"
      find(".link-title").set("")
      click_on "Save"

      within('#links-list') do
        expect(page).to have_content("Test")
        expect(link.title).to eq("Test")
        expect(link.title).to_not eq("")
      end
    end

    it "does not save with an invalid url" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: "read")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      click_on "Edit"
      find(".link-url").set("asdf")
      click_on "Save"

      within('#links-list') do
        expect(page).to have_content("https://www.test.com")
        expect(link.url).to eq("https://www.test.com")
        expect(link.url).to_not eq("asdf")
      end
    end

  end
end
