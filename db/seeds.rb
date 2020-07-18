# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding cars

require 'open-uri'
require 'faker'

puts "Cleaning cars DB"
if Rails.env.development?
  puts "Rails is in development environment"
  Car.destroy_all
end

puts "Seeding cars..."
5.times do
  file = URI.open("https://source.unsplash.com/250x150/?old%20car")
  car = Car.create(
    name: Faker::Vehicle.manufacture + " " + Faker::Marketing.buzzwords,
    price: rand(50...500),
    model: Faker::Vehicle.make_and_model,
    year: rand(1930...1980),
    address: Faker::Address.city,
    engine_type: %w(Diesel Gasoline).sample,
    transmission: %w(Automatic Manual).sample,
    kilometers: Faker::Vehicle.kilometrage,
    user:  User.all.sample
  )
  car.photos.attach(io: file, filename: 'car.png')
end

puts "Done seeding cars"

# ------------------------------------------------

puts "Cleaning reviews DB"
if Rails.env.development?
  puts "Rails is in development environment"
  Review.destroy_all
end

puts "Seeding reviews"
25.times do
  review = Review.create(
    rating: rand(0...5),
    comment: Faker::Quote,
    car: Car.all.sample
  )
end

puts "Done seeding reviews"

# ------------------------------------------------

puts "Cleaning bookings DB"
if Rails.env.development?
  puts "Rails is in development environment"
  Booking.destroy_all
end

puts "Seeding bookings"
20.times do
  starting_date = Faker::Date.between(from: '2019-01-01', to: Time.now)
  booking = Booking.new(
    start_date: starting_date,
    end_date: starting_date + rand(1..31),
    amount: 0,
    validated: false,
    car: Car.all.sample,
    user: User.all.sample
  )
  booking.amount = (booking.end_date - booking.start_date) * booking.car.price
  booking.save
end

puts "Done seeding bookings"