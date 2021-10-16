class User < ApplicationRecord

  has_secure_password
  has_one_attached :image
  has_many :rooms
  has_many :bookings

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { in: 5..20 }, on: [:create, :update_account]
  validates :password, confirmation: true, on: [:create, :update_account]
  validates :password_confirmation, presence: true, on: [:create, :update_account]
  validates :name, presence: true

end