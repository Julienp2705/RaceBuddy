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

Message.destroy_all
Chat.destroy_all
Invite.destroy_all
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

# Seeds pour avoir un chat
# 1. Récupérer ou créer deux utilisateurs
user1 = User.create!(
  first_name: "Paul",
  last_name: "Martin",
  email: "paul@test.com",
  password: "password"
)

user2 = User.create!(
  first_name: "Marie",
  last_name: "Dupont",
  email: "marie@test.com",
  password: "password"
)

# 2. Créer une course
race = Race.create!(
  name: "Semi-marathon de Bordeaux",
  distance: 21.1,
  url: "https://example.com"
)

# 3. Créer un objectif pour user1
target = Target.create!(
  user: user1,
  race: race,
  target_hour: 1,
  target_minute: 45
)

# 4. Créer une invitation de user2 vers le target de user1
invite = Invite.create!(
  user: user2,
  target: target,
  status: "accepted"
)

# 5. Créer le chat associé à l'invitation
chat = Chat.create!(
  invite: invite,
  title: "Chat de test"
)

# 6. Créer quelques messages pour tester la vue
Message.create!(
  chat: chat,
  user: user1,
  content: "Salut ! Tu te prépares aussi pour le semi ?"
)

Message.create!(
  chat: chat,
  user: user2,
  content: "Oui ! Je vise environ 1h45, et toi ?"
)

Message.create!(
  chat: chat,
  user: user1,
  content: "Moi aussi, ce serait cool de s'entraîner ensemble !"
)

# 7. Donner un objectif à Julien (le compte de connexion) pour qu'il puisse recevoir des invitations
target_julien = Target.create!(
  user: julien,
  race: race2,
  target_hour: 3,
  target_minute: 45
)

# 8. Trois invitations EN ATTENTE reçues par Julien
Invite.create!(
  user: laurie,
  target: target_julien,
  status: "pending"
)

Invite.create!(
  user: alex,
  target: target_julien,
  status: "pending"
)

Invite.create!(
  user: robert,
  target: target_julien,
  status: "pending"
)

puts "Julien a #{julien.received_invites.pending.count} invitation(s) en attente"

puts "seed finished"
