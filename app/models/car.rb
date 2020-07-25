class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  
  validates :name, :price, :model, :year, :address, :user, presence: true
  validates :engine_type, inclusion: { in: %w(Diesel Gasoline),
    message: "%{value} is not a valid engine type" }
  validates :transmission, inclusion: { in: %w(Automatic Manual),
    message: "%{value} is not valid transmission type"}

  # Ideally validate address as well ==> later if possible
  include PgSearch::Model
  pg_search_scope :search_by_name_and_year,
    against: [ :name, :year ],
    using: {
      tsearch: { prefix: true }
    }


  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      {
        from: range[0],
        to: range[1]
      }
    end
  end
end
