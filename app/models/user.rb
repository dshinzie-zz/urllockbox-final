class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  validates_confirmation_of :password
  has_secure_password

  has_many :links
end
