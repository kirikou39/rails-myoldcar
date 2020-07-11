class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy

  validates :name, :price, :model, :year, :address, presence: true
  validates :engine_type, inclusion: { in: %w(diesel gasoline),
    message: "%{value} is not a valid engine type" }
  validates :transmission, inclusion: { in: %w(automatic manual),
    message: "%{value} is not valid transmission type"}

  # Ideally validate address as well ==> later if possible

end
