class Link < ApplicationRecord
  scope :hot, -> {
    select('links.url as url')
      .joins('join reads on reads.link_id = links.id')
      .where('reads.created_at > ?', Time.now - 1.day)
      .group("links.url")
      .order('count("reads".id) DESC').limit(10)
  }

  validates :title, :url, presence: true
  belongs_to :user

  # after_update :publish_link

  def invalid_link?
    uri = URI.parse(self.url)
    uri.host.nil?
  end

  # def publish_link
  #   pubsub = PubSub.new
  #   link = { lockbox_id: self.id, url: self.url, title: self.title, read: self.read, user_id: self.user_id }
  #   pubsub.publish_to_queue(link)
  # end
end
