class Link < ApplicationRecord
  validates :title, :url, presence: true
  belongs_to :user

  after_update :publish_link#, if: :read_changed?

  scope :existing, -> { where("links.id is not null").order(updated_at: :desc)}

  def invalid_link?
    uri = URI.parse(url)
    uri.host.nil? || url.length == 0
  end


end
