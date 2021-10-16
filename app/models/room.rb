class Room < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :bookings

  validates :name, length: { in: 3..50 }, presence: true
  validates :introduction, length: { in: 5..300 }, presence: true
  validates :charge, presence: true, numericality: { in: 1..100 }
  validates :address,length: { in: 3..100 }, presence: true
  validates :image, presence: true

end
