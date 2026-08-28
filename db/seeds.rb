# db/seeds.rb

puts "🌱 Nettoyage des données..."

# On supprime dans l'ordre pour respecter les foreign keys
Message.destroy_all
Chat.destroy_all
Invite.destroy_all
Review.destroy_all
Target.destroy_all
Race.destroy_all
User.destroy_all

puts "✅ Base nettoyée"


# ============================================================
# USERS
# ============================================================

puts "👤 Création des utilisateurs..."

users_data = [
  # Bordeaux et alentours
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

  # Autres villes
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

# On complète automatiquement jusqu'à 50 utilisateurs
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

while users_data.length < 50
  index = users_data.length

  users_data << {
    first_name: first_names[index % first_names.length],
    last_name: last_names[index % last_names.length],
    email: "runner#{index + 1}@example.com",
    city: ["Paris", "Lyon", "Toulouse", "Nantes", "Nice", "Lille"].sample
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

races = races_data.map.with_index do |(name, distance), index|
  Race.create!(
    name: name,
    distance: distance,
    url: "https://example.com/races/#{index + 1}"
  )
end

puts "✅ #{races.count} courses créées"


# ============================================================
# TARGETS
# ============================================================

puts "🎯 Création des objectifs..."

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
  "Lille" => [50.6292, 3.0573]
}

targets = []

# ============================================================
# OBJECTIFS SPÉCIFIQUES — GROUPE BORDEAUX
# ============================================================

bordeaux_race = races.find { |race| race.name == "Semi-marathon de Bordeaux" }

bordeaux_users = users.select do |user|
  ["Laurie", "Robert", "Julien"].include?(user.first_name)
end

# Même objectif pour les 3 utilisateurs
target_hour = 1
target_minute = 45

# Différents points autour de Bordeaux, tous à moins de 5 km
bordeaux_locations = {
  "Laurie" => [44.8378, -0.5792], # Bordeaux
  "Robert" => [44.8085, -0.5505], # Bègles
  "Julien" => [44.8558, -0.5238]  # Cenon
}

bordeaux_users.each do |user|

  latitude, longitude = bordeaux_locations[user.first_name]

  targets << Target.create!(
    user: user,
    race: bordeaux_race,
    target_hour: target_hour,
    target_minute: target_minute,
    address: "Bordeaux",
    latitude: latitude,
    longitude: longitude
  )

end

puts "🏃 #{bordeaux_users.count} objectifs Bordeaux créés"


# ============================================================
# AUTRES OBJECTIFS
# ============================================================

users.each_with_index do |user, index|

  # Laurie, Robert et Julien ont déjà leur objectif Bordeaux.
  # Alex est volontairement laissé de côté pour le créer depuis l'app.
  next if ["Laurie", "Robert", "Julien", "Alex"].include?(user.first_name)

  race = races[index % races.length]

  city = users_data[index][:city]
  latitude, longitude = locations[city]

  target = Target.create!(
    user: user,
    race: race,
    target_hour: [2, 2, 3, 3, 4].sample,
    target_minute: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].sample,
    address: city,
    latitude: latitude,
    longitude: longitude
  )

  targets << target

  # Quelques utilisateurs ont un deuxième objectif
  if index % 4 == 0
    race = races[(index + 7) % races.length]

    targets << Target.create!(
      user: user,
      race: race,
      target_hour: [2, 3, 4].sample,
      target_minute: [0, 10, 20, 30, 40, 50].sample,
      address: city,
      latitude: latitude,
      longitude: longitude
    )
  end
end

puts "✅ #{targets.count} objectifs créés"


# ============================================================
# INVITES
# ============================================================

puts "🤝 Création des invitations..."

invites = []

# Chaque target reçoit quelques invitations
targets.each_with_index do |target, index|

  possible_users = users.reject do |user|
    user.id == target.user_id
  end

  # Entre 1 et 3 invitations par objectif
  number_of_invites = [1, 2, 3].sample

  possible_users.sample(number_of_invites).each do |user|

    invite = Invite.create!(
      user: user,
      target: target,
      status: ["pending", "accepted"].sample
    )

    invites << invite
  end
end

puts "✅ #{invites.count} invitations créées"


# ============================================================
# CHATS
# ============================================================

puts "💬 Création des conversations..."

chats = []

# On crée surtout des conversations pour les invitations acceptées
accepted_invites = invites.select { |invite| invite.status == "accepted" }

accepted_invites.each_with_index do |invite, index|

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

chats.each_with_index do |chat, chat_index|

  # Les conversations récentes ont entre 4 et 12 messages
  number_of_messages = rand(4..12)

  # Les deux utilisateurs de la conversation
  user_one = chat.invite.user
  user_two = chat.invite.target.user

  number_of_messages.times do |message_index|

    sender = message_index.even? ? user_one : user_two

    Message.create!(
      chat: chat,
      user: sender,
      content: messages_content.sample,
      created_at: (number_of_messages - message_index).days.ago + rand(1..12).hours,
      updated_at: (number_of_messages - message_index).days.ago + rand(1..12).hours
    )
  end
end

puts "✅ #{Message.count} messages créés"


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
puts "======================================"
