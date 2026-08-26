# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "seed started"

Target.destroy_all
Race.destroy_all
User.destroy_all

laurie = User.create!(
  first_name: "Laurie",
  last_name: "Lescos",
  email: "laurie@racebuddy.com",
  password: "password123",
  latitude: 50.6292,
  longitude: 3.0573
)

alex = User.create!(
  first_name: "Alex",
  last_name: "Kerespars",
  email: "alex@racebuddy.com",
  password: "password123",
  latitude: 50.6293,
  longitude: 3.1444
)

julien = User.create!(
  first_name: "Julien",
  last_name: "Poulain",
  email: "julien@racebuddy.com",
  password: "password123",
  latitude: 50.6927,
  longitude: 3.1778
)

robert = User.create!(
  first_name: "Robert",
  last_name: "Delaoutre",
  email: "robert@racebuddy.com",
  password: "password123",
  latitude: 50.6704,
  longitude: 3.1338
)

puts "Users created!"


race1 = Race.create!(
  name: "Semi-marathon de moneteau",
  distance: 20,
  url: "https://www.finishers.com/course/semi-marathon-de-moneteau" 
)

race2 = Race.create!(
  name: "Marathon de Paris",
  distance: 42,
  url: "https://www.finishers.com/course/marathon-de-paris"
)

race3 = Race.create!(
  name: "10 km de Lille",
  distance: 10,
  url: "https://www.finishers.com/course/urban-trail-de-lille"
)

Target.create!(
  user: robert,
  race: race1,
  target_hour: 1,
  target_minute: 45
)

Target.create!(
  user: laurie,
  race: race1,
  target_hour: 1,
  target_minute: 50
)

puts "seed finished"

