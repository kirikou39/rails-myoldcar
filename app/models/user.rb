class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_many :cars, dependent: :destroy

  validates :username, :category, presence: true
  validates :category, inclusion: { in: %w(owner driver),
    message: "%{value} is not a valid User category" }
end
