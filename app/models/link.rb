class Link < ApplicationRecord
  validates :title, :url, presence: true
  belongs_to :user

  before_save :publish_link, if: :read_changed?

  scope :existing, -> { where("links.id is not null").order(updated_at: :desc)}

  def invalid_link?
    uri = URI.parse(url)
    uri.host.nil? || url.length == 0
  end

  def publish_link
    connection = Bunny.new({:host => "experiments.turing.io", :port => "5672", :user => "student", :pass => "PLDa{g7t4Fy@47H"})
    # connection = Bunny.new(ENV["publisher"])

    publisher = PubSub.new(connection)
    link = { url: url, title: title, read: read, lockbox_id: id, user_id: user_id }
    publisher.publish_to_queue(link)
  end

  def self.get_top_links
    connection = Bunny.new({:host => "experiments.turing.io", :port => "5672", :user => "student", :pass => "PLDa{g7t4Fy@47H"})
    # connection = Bunny.new(ENV["publisher"])

    pubsub = PubSub.new(connection)
    pubsub.subscribe_to_queue_top
    pubsub.subscribe_to_queue
  end
end
