require 'rails_helper'

describe "publisher" do
  context "publishing data" do
    it "received payload" do
      user = User.create(email: "test@test.com", password: "test")
      link = user.links.create(title: "Test", url: "https://www.test.com", read: "read")

      connection = BunnyMock.new
      publisher = Publisher.new(connection)
      link = { lockbox_id: link.id, url: link.url, title: link.title, read: link.read, user_id: user.id }
      publication = publisher.publish_to_queue(link)

      expect(publication).to_not eq(nil)
      expect(publication.name).to eq("ds.lockbox.to.hotreads")
      expect(publication.channel.connection).to_not eq(nil)
    end
  end
end
