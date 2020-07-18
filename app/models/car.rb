class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  
  validates :name, :price, :model, :year, :address, presence: true
  validates :engine_type, inclusion: { in: %w(Diesel Gasoline),
    message: "%{value} is not a valid engine type" }
  validates :transmission, inclusion: { in: %w(Automatic Manual),
    message: "%{value} is not valid transmission type"}

  # Ideally validate address as well ==> later if possible

end
