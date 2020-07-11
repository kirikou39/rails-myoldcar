class Review < ApplicationRecord
  belongs_to :car

  validates :rating, presence: true, inclusion: { in: 1..5,
    message: "%{value} is not a valid rating" }
end
