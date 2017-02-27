class Link < ApplicationRecord
  scope :hot, -> {
    select('links.url as url')
      .joins('join reads on reads.link_id = links.id')
      .where('reads.created_at > ?', Time.now - 1.day)
      .group("links.url")
      .order('count("reads".id) DESC').limit(10)
  }

  scope :existing, -> { where("links.id is not null")}

  validates :title, :url, presence: true
  belongs_to :user

  after_update :publish_link

  def invalid_link?
    uri = URI.parse(url)
    uri.host.nil? || url.length == 0 
  end

  def publish_link
    connection = Bunny.new({:host => "experiments.turing.io", :port => "5672", :user => "student", :pass => "PLDa{g7t4Fy@47H"})
    # connection = Bunny.new(ENV["publisher"])

    publisher = Publisher.new(connection)
    link = { lockbox_id: id, url: url, title: title, read: read, user_id: user_id }
    publisher.publish_to_queue(link)
  end
end
