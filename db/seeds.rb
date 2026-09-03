# db/seeds.rb

puts "🌱 Nettoyage des données..."

# ============================================================
# NETTOYAGE
# ============================================================

Message.destroy_all
Chat.destroy_all
BuddyRating.destroy_all
Invite.destroy_all
Target.destroy_all
Race.destroy_all
User.destroy_all

puts "✅ Base nettoyée"


# ============================================================
# USERS
# ============================================================

puts "👤 Création des utilisateurs..."

users_data = [
  # ----------------------------------------------------------
  # BORDEAUX ET ALENTOURS
  # ----------------------------------------------------------

  {
    first_name: "Alex",
    last_name: "Kerespars",
    email: "alex@example.com",
    city: "Bordeaux"
  },
  {
    first_name: "Laurie",
    last_name: "Lescos",
    email: "laurie@example.com",
    city: "Bordeaux"
  },
  {
    first_name: "Julien",
    last_name: "Poulain",
    email: "julien@example.com",
    city: "Talence"
  },
  {
    first_name: "Robert",
    last_name: "Delaoutre",
    email: "robert@example.com",
    city: "Pessac"
  },
  {
    first_name: "Emma",
    last_name: "Robert",
    email: "emma.robert@example.com",
    city: "Talence"
  },
  {
    first_name: "Hugo",
    last_name: "Richard",
    email: "hugo.richard@example.com",
    city: "Bordeaux"
  },
  {
    first_name: "Clara",
    last_name: "Durand",
    email: "clara.durand@example.com",
    city: "Bordeaux"
  },
  {
    first_name: "Maxime",
    last_name: "Moreau",
    email: "maxime.moreau@example.com",
    city: "Bègles"
  },
  {
    first_name: "Chloé",
    last_name: "Simon",
    email: "chloe.simon@example.com",
    city: "Bordeaux"
  },
  {
    first_name: "Nathan",
    last_name: "Laurent",
    email: "nathan.laurent@example.com",
    city: "Cenon"
  },

  # ----------------------------------------------------------
  # AUTRES VILLES
  # ----------------------------------------------------------

  {
    first_name: "Camille",
    last_name: "Lefèvre",
    email: "camille.lefevre@example.com",
    city: "Paris"
  },
  {
    first_name: "Louis",
    last_name: "Michel",
    email: "louis.michel@example.com",
    city: "Lyon"
  },
  {
    first_name: "Sarah",
    last_name: "Garcia",
    email: "sarah.garcia@example.com",
    city: "Toulouse"
  },
  {
    first_name: "Antoine",
    last_name: "David",
    email: "antoine.david@example.com",
    city: "Nantes"
  },
  {
    first_name: "Laura",
    last_name: "Bertrand",
    email: "laura.bertrand@example.com",
    city: "Montpellier"
  }
]

first_names = [
  "Paul", "Marie", "Arthur", "Léa", "Gabriel",
  "Manon", "Nathan", "Inès", "Jules", "Zoé",
  "Romain", "Eva", "Alexandre", "Louise", "Mathis",
  "Sophie", "Baptiste", "Élodie", "Théo", "Margot"
]

last_names = [
  "Leroy", "Roux", "Faure", "Blanc", "Garnier",
  "Chevalier", "Robin", "Masson", "Henry", "Marchand",
  "Noël", "Meyer", "Girard", "André", "Mercier"
]

cities = [
  "Paris",
  "Lyon",
  "Toulouse",
  "Nantes",
  "Nice",
  "Lille"
]

while users_data.length < 50
  index = users_data.length

  users_data << {
    first_name: first_names[index % first_names.length],
    last_name: last_names[index % last_names.length],
    email: "runner#{index + 1}@example.com",
    city: cities.sample
  }
end

users = users_data.map do |data|
  User.create!(
    first_name: data[:first_name],
    last_name: data[:last_name],
    email: data[:email],
    password: "password"
  )
end

puts "✅ #{users.count} utilisateurs créés"


# ============================================================
# RACES
# ============================================================

puts "🏃 Création des courses..."

races_data = [
  ["Marathon de Bordeaux", 42.195],
  ["Semi-Marathon de Bordeaux", 21.1],
  ["10 km de Bordeaux", 10],
  ["Marathon de Paris", 42.195],
  ["Semi-Marathon de Paris", 21.1],
  ["Marathon de Lyon", 42.195],
  ["Semi-Marathon de Lyon", 21.1],
  ["Marathon de Toulouse", 42.195],
  ["10 km de Toulouse", 10],
  ["Marathon de Nantes", 42.195],
  ["Semi-Marathon de Nantes", 21.1],
  ["Marathon de Nice", 42.195],
  ["Trail des Vignes", 25],
  ["Trail du Médoc", 30],
  ["Course des Lumières", 10],
  ["Urban Trail Bordeaux", 15],
  ["Les Foulées de Pessac", 10],
  ["Les Foulées de Mérignac", 10],
  ["Run & Wine", 12],
  ["Bordeaux Night Run", 10],
  ["Marathon des Landes", 42.195],
  ["Trail du Bassin", 32],
  ["Course du Lac", 15],
  ["Semi-Marathon de La Rochelle", 21.1],
  ["Marathon de La Rochelle", 42.195],
  ["Trail de la Dune", 20],
  ["Les 20 km de Paris", 20],
  ["Ekiden de Bordeaux", 42.195],
  ["Bordeaux Relais Running", 10],
  ["Gironde Running Challenge", 21.1]
]

races = races_data.each_with_index.map do |(name, distance), index|
  Race.create!(
    name: name,
    distance: distance,
    url: "https://example.com/races/#{name.parameterize}",
    race_date: Date.current + (index + 1).months
  )
end

puts "✅ #{races.count} courses créées"


# ============================================================
# LOCATIONS
# ============================================================

locations = {
  "Bordeaux" => [44.8378, -0.5792],
  "Mérignac" => [44.8378, -0.6435],
  "Pessac" => [44.8067, -0.6312],
  "Talence" => [44.8048, -0.5952],
  "Bègles" => [44.8085, -0.5505],
  "Cenon" => [44.8558, -0.5238],
  "Paris" => [48.8566, 2.3522],
  "Lyon" => [45.7640, 4.8357],
  "Toulouse" => [43.6047, 1.4442],
  "Nantes" => [47.2184, -1.5536],
  "Nice" => [43.7102, 7.2620],
  "Lille" => [50.6292, 3.0573],
  "Montpellier" => [43.6108, 3.8767]
}

postcodes = {
  "Bordeaux" => "33000",
  "Mérignac" => "33700",
  "Pessac" => "33600",
  "Talence" => "33400",
  "Bègles" => "33130",
  "Cenon" => "33150",
  "Paris" => "75001",
  "Lyon" => "69001",
  "Toulouse" => "31000",
  "Nantes" => "44000",
  "Nice" => "06000",
  "Lille" => "59000",
  "Montpellier" => "34000"
}
# ============================================================
# TARGETS
# ============================================================

puts "🎯 Création des objectifs..."

targets = []


# ============================================================
# OBJECTIFS BORDEAUX
#.
# ============================================================
bordeaux_race = races.find do |race|
  race.name == "Marathon de Bordeaux"
end

raise "❌ Marathon de Bordeaux introuvable !" unless bordeaux_race

bordeaux_buddies = [
  {
    first_name: "Laurie",
    address: "33000", # Bordeaux Centre
    latitude: 44.8378,
    longitude: -0.5792,
    target_hour: 3,
    target_minute: 15
  },
  {
    first_name: "Alex",
    address: "33400", # Talence
    latitude: 44.8048,
    longitude: -0.5952,
    target_hour: 3,
    target_minute: 20
  },
  {
    first_name: "Julien",
    address: "33100", # Bastide
    latitude: 44.8410,
    longitude: -0.5520,
    target_hour: 3,
    target_minute: 25
  },
  {
    first_name: "Emma",
    address: "33200", # Caudéran
    latitude: 44.8480,
    longitude: -0.6110,
    target_hour: 3,
    target_minute: 30
  },
  {
    first_name: "Hugo",
    address: "33800", # Saint-Michel
    latitude: 44.8270,
    longitude: -0.5700,
    target_hour: 3,
    target_minute: 35
  },
  {
    first_name: "Clara",
    address: "33110", # Le Bouscat
    latitude: 44.8626,
    longitude: -0.6003,
    target_hour: 3,
    target_minute: 40
  },
  {
    first_name: "Chloé",
    address: "33270", # Floirac
    latitude: 44.8422,
    longitude: -0.5385,
    target_hour: 3,
    target_minute: 45
  }
]

bordeaux_buddies.each do |buddy_data|
  user = users.find { |u| u.first_name == buddy_data[:first_name] }

  target = Target.create!(
    user: user,
    race: bordeaux_race,
    target_hour: buddy_data[:target_hour],
    target_minute: buddy_data[:target_minute],
    address: buddy_data[:address],
    latitude: buddy_data[:latitude],
    longitude: buddy_data[:longitude]
  )
  targets << target
end

puts "✅ #{bordeaux_buddies.count} buddies Marathon de Bordeaux créés"

# ============================================================
# AUTRES OBJECTIFS
# ============================================================

users.each_with_index do |user, index|

  #
  next if ["Robert","Laurie","Alex","Julien","Emma","Hugo","Clara","Chloé"].include?(user.first_name)

  city = users_data[index][:city]
  latitude, longitude = locations[city]

  race = races[index % races.length]

  target = Target.create!(
    user: user,
    race: race,
    target_hour: [2, 2, 3, 3, 4].sample,
    target_minute: [
      0, 5, 10, 15, 20, 25,
      30, 35, 40, 45, 50, 55
    ].sample,
    address: postcodes.fetch(city, city),
    latitude: latitude,
    longitude: longitude
  )

  targets << target

  # Un deuxième objectif pour certains utilisateurs
  if index % 4 == 0

    second_race = races[(index + 7) % races.length]

    second_target = Target.create!(
      user: user,
      race: second_race,
      target_hour: [2, 3, 4].sample,
      target_minute: [
        0, 10, 20, 30, 40, 50
      ].sample,
      address: postcodes.fetch(city, city),
      latitude: latitude,
      longitude: longitude
    )

    targets << second_target
  end
end

puts "✅ #{targets.count} objectifs créés"


# ============================================================
# INVITES
# ============================================================

invites = []
invited_pairs = Set.new

targets.each do |target|

  possible_users = users.reject do |user|
    user.id == target.user_id ||
      invited_pairs.include?([user.id, target.user_id].sort)
  end

  # Entre 1 et 3 invitations
  possible_users.sample(rand(1..3)).each do |user|

    invite = Invite.create!(
      user: user,
      target: target,
      status: ["pending", "accepted"].sample
    )

    invited_pairs << [user.id, target.user_id].sort
    invites << invite
  end
end

puts "✅ #{invites.count} invitations créées"


# ============================================================
# CHATS
# ============================================================

puts "💬 Création des conversations..."

chats = []

accepted_invites = invites.select do |invite|
  invite.status == "accepted"
end

accepted_invites.each do |invite|

  chat = Chat.create!(
    invite: invite,
    title: "#{invite.target.user.first_name} #{invite.target.user.last_name}"
  )

  chats << chat
end

puts "✅ #{chats.count} conversations créées"


# ============================================================
# MESSAGES
# ============================================================

puts "✉️ Création des messages..."

messages_content = [
  "Salut ! Tu t'entraînes pour cette course ?",
  "Oui, je prépare la course depuis quelques semaines !",
  "Tu vises quel temps ?",
  "J'aimerais passer sous les 2 heures.",
  "Ça serait top de faire une sortie ensemble !",
  "Carrément, je suis disponible ce week-end.",
  "Tu cours plutôt le matin ou le soir ?",
  "Je préfère courir le matin quand il ne fait pas trop chaud.",
  "On peut se retrouver sur les quais ?",
  "Oui, ça me va parfaitement.",
  "Tu fais combien de kilomètres par semaine ?",
  "Environ 35 à 40 km actuellement.",
  "Ça progresse bien alors !",
  "Oui, je commence à sentir une vraie différence.",
  "On se tient au courant pour la prochaine sortie.",
  "Avec plaisir ! À bientôt 🏃",
  "Bonne préparation pour la course !",
  "Merci, toi aussi ! 💪"
]

chats.each do |chat|

  user_one = chat.invite.user
  user_two = chat.invite.target.user

  number_of_messages = rand(4..12)

  number_of_messages.times do |message_index|

    sender = message_index.even? ? user_one : user_two

    # On crée un historique progressif
    created_at = rand(1..30).days.ago + rand(0..12).hours

    Message.create!(
      chat: chat,
      user: sender,
      content: messages_content.sample,
      created_at: created_at,
      updated_at: created_at
    )
  end
end

puts "✅ #{Message.count} messages créés"


# ============================================================
# BUDDY RATINGS
# ============================================================

puts "👍 Création des évaluations des buddies..."

buddy_ratings = []

accepted_invites = invites.select do |invite|
  invite.status == "accepted"
end

accepted_invites.sample([accepted_invites.length, 15].min).each do |invite|

  user = invite.target.user
  buddy = invite.user

  next if user == buddy
  next if BuddyRating.exists?(user: user, buddy: buddy)

  buddy_rating = BuddyRating.create!(
    user: user,
    buddy: buddy,
    rating: [1, 1, 1, 1, -1].sample
  )

  buddy_ratings << buddy_rating
end

puts "✅ #{buddy_ratings.count} évaluations créées"

# ============================================================
# RÉCAPITULATIF
# ============================================================

puts ""
puts "======================================"
puts "🎉 SEEDS TERMINÉS !"
puts "======================================"
puts "👤 Users    : #{User.count}"
puts "🏃 Races    : #{Race.count}"
puts "🎯 Targets  : #{Target.count}"
puts "🤝 Invites  : #{Invite.count}"
puts "💬 Chats    : #{Chat.count}"
puts "✉️ Messages : #{Message.count}"
puts "👍 Ratings  : #{BuddyRating.count}"
puts "======================================"
puts ""
puts "🔐 Mot de passe des utilisateurs : password"
puts ""
puts "🏃 Démo Marathon de Bordeaux :"
puts "   Laurie  → 3h15"
puts "   Alex    → 3h20"
puts "   Julien  → 3h25"
puts "   Emma    → 3h30"
puts "   Hugo    → 3h35"
puts "   Clara   → 3h40"
puts "   Chloé   → 3h45"
puts ""
puts "   Robert  → aucun objectif"
puts "   👉 À créer pendant la démo : Marathon de Bordeaux → 3h30"
puts "======================================"
