class AvailabilityValidator < ActiveModel::EachValidator
  # https://medium.com/lightthefuse/ruby-on-rails-date-validation-in-a-booking-and-disabling-dates-in-date-picker-3e5b4e9b4640
  def validate_each(record, attribute, value)
    bookings = Booking.where(["car_id =?", record.car_id])
    date_ranges = bookings.map { |booking| booking.start_date..booking.end_date }

    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "not available")
      end
    end
  end
end