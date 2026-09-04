# db/seeds.rb

puts "🌱 Nettoyage des données..."

Message.delete_all
Chat.delete_all
BuddyRating.delete_all
Invite.delete_all
Target.delete_all
Race.delete_all
User.delete_all

puts "✅ Base nettoyée"


# ============================================================
# LIEUX (codes postaux de la métropole bordelaise)
# ============================================================

BORDEAUX_SPOTS = {
  "33000" => [44.8378, -0.5792], # Bordeaux centre
  "33100" => [44.8410, -0.5520], # La Bastide
  "33110" => [44.8626, -0.6003], # Le Bouscat
  "33130" => [44.8085, -0.5505], # Bègles
  "33150" => [44.8558, -0.5238], # Cenon
  "33170" => [44.7725, -0.6156], # Gradignan
  "33200" => [44.8480, -0.6110], # Caudéran
  "33270" => [44.8422, -0.5385], # Floirac
  "33300" => [44.8650, -0.5650], # Bordeaux Nord
  "33400" => [44.8048, -0.5952], # Talence
  "33600" => [44.8067, -0.6312], # Pessac
  "33700" => [44.8378, -0.6435], # Mérignac
  "33800" => [44.8270, -0.5700]  # Saint-Michel
}.freeze

OTHER_SPOTS = {
  "75011" => [48.8566, 2.3522],  # Paris
  "69003" => [45.7640, 4.8357],  # Lyon
  "31000" => [43.6047, 1.4442],  # Toulouse
  "44000" => [47.2184, -1.5536], # Nantes
  "06000" => [43.7102, 7.2620],  # Nice
  "59000" => [50.6292, 3.0573],  # Lille
  "34000" => [43.6108, 3.8767]   # Montpellier
}.freeze

ALL_SPOTS = BORDEAUX_SPOTS.merge(OTHER_SPOTS).freeze


# ============================================================
# USERS
# ============================================================

puts "👤 Création des utilisateurs..."

named_users = [
  { first_name: "Laurie",  last_name: "Lescos" },
  { first_name: "Robert",  last_name: "Delaoutre" },
  { first_name: "Julien",  last_name: "Poulain" },
  { first_name: "Alex",    last_name: "Kerespars" },
  { first_name: "Emma",    last_name: "Robert" },
  { first_name: "Hugo",    last_name: "Richard" },
  { first_name: "Clara",   last_name: "Durand" },
  { first_name: "Chloé",   last_name: "Simon" },
  { first_name: "Maxime",  last_name: "Moreau" },
  { first_name: "Nathan",  last_name: "Laurent" },
  { first_name: "Camille", last_name: "Lefèvre" },
  { first_name: "Louis",   last_name: "Michel" },
  { first_name: "Sarah",   last_name: "Garcia" },
  { first_name: "Antoine", last_name: "David" },
  { first_name: "Laura",   last_name: "Bertrand" }
]

filler_first_names = %w[
  Paul Marie Arthur Léa Gabriel Manon Inès Jules Zoé Romain
  Eva Alexandre Louise Mathis Sophie Baptiste Élodie Théo Margot Lucas
]

filler_last_names = %w[
  Leroy Roux Faure Blanc Garnier Chevalier Robin Masson Henry Marchand
  Noël Meyer Girard André Mercier
]

30.times do |i|
  named_users << {
    first_name: filler_first_names[i % filler_first_names.length],
    last_name: filler_last_names[i % filler_last_names.length]
  }
end

users = named_users.each_with_index.map do |data, index|
  email = index < 15 ? "#{data[:first_name].parameterize}@example.com"
                     : "runner#{index}@example.com"

  User.create!(
    first_name: data[:first_name],
    last_name: data[:last_name],
    email: email,
    password: "password"
  )
end

def find_user(users, first_name)
  users.find { |u| u.first_name == first_name }
end

laurie = find_user(users, "Laurie")
robert = find_user(users, "Robert")
julien = find_user(users, "Julien")

puts "✅ #{users.count} utilisateurs créés"


# ============================================================
# RACES
# ============================================================

puts "🏃 Création des courses..."

# --- La course vedette de la démo -------------------------------------------

bordeaux_marathon = Race.create!(
  name: "Marathon de Bordeaux",
  distance: 42.195,
  race_date: Date.new(2026, 11, 8),
  url: "https://www.marathon-de-bordeaux-ag2r-la-mondiale.fr/"
)

# --- Courses passées (pour l'historique de Laurie et Robert) ----------------

past_races = [
  ["Semi-Marathon de Bordeaux",    21.1,  Date.current - 12.months],
  ["10 km de Bordeaux",            10.0,  Date.current - 11.months],
  ["Marathon de La Rochelle",      42.195, Date.current - 8.months],
  ["Trail du Médoc",               30.0,  Date.current - 6.months],
  ["Les Foulées de Pessac",        10.0,  Date.current - 2.months]
].map do |name, distance, date|
  Race.create!(
    name: name,
    distance: distance,
    race_date: date,
    url: "https://example.com/courses/#{name.parameterize}"
  )
end

semi_bordeaux    = past_races[0]
dix_km_bordeaux  = past_races[1]
marathon_rochelle = past_races[2]
trail_medoc      = past_races[3]

# --- Autres courses à venir -------------------------------------------------

upcoming_races = [
  ["Marathon de Paris",             42.195, 2],
  ["Semi-Marathon de Paris",        21.1,   3],
  ["Marathon de Lyon",              42.195, 4],
  ["Semi-Marathon de Lyon",         21.1,   5],
  ["Marathon de Toulouse",          42.195, 6],
  ["10 km de Toulouse",             10.0,   1],
  ["Marathon de Nantes",            42.195, 7],
  ["Semi-Marathon de Nantes",       21.1,   8],
  ["Marathon de Nice",              42.195, 9],
  ["Trail des Vignes",              25.0,   3],
  ["Urban Trail Bordeaux",          15.0,   5],
  ["Les Foulées de Mérignac",       10.0,   2],
  ["Run & Wine",                    12.0,   6],
  ["Bordeaux Night Run",            10.0,   4],
  ["Marathon des Landes",           42.195, 10],
  ["Trail du Bassin",               32.0,   7],
  ["Course du Lac",                 15.0,   3],
  ["Semi-Marathon de La Rochelle",  21.1,   8],
  ["Trail de la Dune",              20.0,   9],
  ["Les 20 km de Paris",            20.0,   11]
].map do |name, distance, months|
  Race.create!(
    name: name,
    distance: distance,
    race_date: Date.current + months.months,
    url: "https://example.com/courses/#{name.parameterize}"
  )
end

all_races = [bordeaux_marathon] + past_races + upcoming_races

puts "✅ #{Race.count} courses créées"


# ============================================================
# TARGETS
# ============================================================

puts "🎯 Création des objectifs..."

targets = []

def build_target(targets, user:, race:, hour:, minute:, postcode:, spots:)
  latitude, longitude = spots.fetch(postcode)

  target = Target.create!(
    user: user,
    race: race,
    target_hour: hour,
    target_minute: minute,
    address: postcode,
    latitude: latitude,
    longitude: longitude
  )

  targets << target
  target
end

# --- Laurie : deux courses passées + le marathon à venir --------------------

build_target(targets, user: laurie, race: semi_bordeaux,
             hour: 1, minute: 50, postcode: "33000", spots: ALL_SPOTS)

build_target(targets, user: laurie, race: marathon_rochelle,
             hour: 3, minute: 55, postcode: "33000", spots: ALL_SPOTS)

laurie_target = build_target(targets, user: laurie, race: bordeaux_marathon,
                             hour: 3, minute: 45, postcode: "33000", spots: ALL_SPOTS)

# --- Robert : une course passée + le marathon à venir -----------------------

build_target(targets, user: robert, race: trail_medoc,
             hour: 3, minute: 20, postcode: "33200", spots: ALL_SPOTS)

build_target(targets, user: robert, race: dix_km_bordeaux,
             hour: 0, minute: 50, postcode: "33200", spots: ALL_SPOTS)

robert_target = build_target(targets, user: robert, race: bordeaux_marathon,
                             hour: 3, minute: 45, postcode: "33200", spots: ALL_SPOTS)

# --- Julien : aucun objectif (profil neuf, à remplir pendant la démo) -------

# --- Les autres buddies du Marathon de Bordeaux, autour de 3h45 -------------

bordeaux_buddies = [
  { name: "Alex",   hour: 3, minute: 30, postcode: "33400" }, # -15 min
  { name: "Chloé",  hour: 3, minute: 35, postcode: "33270" }, # -10 min
  { name: "Hugo",   hour: 3, minute: 40, postcode: "33800" }, # -5 min
  { name: "Maxime", hour: 3, minute: 40, postcode: "33130" }, # -5 min
  { name: "Clara",  hour: 3, minute: 50, postcode: "33110" }, # +5 min
  { name: "Emma",   hour: 3, minute: 55, postcode: "33600" }, # +10 min
  { name: "Nathan", hour: 4, minute: 0,  postcode: "33150" }  # +15 min
]

bordeaux_targets = bordeaux_buddies.map do |buddy|
  build_target(targets,
               user: find_user(users, buddy[:name]),
               race: bordeaux_marathon,
               hour: buddy[:hour],
               minute: buddy[:minute],
               postcode: buddy[:postcode],
               spots: ALL_SPOTS)
end

puts "✅ #{targets.count} objectifs sur le Marathon de Bordeaux et l'historique"

# --- Le reste des utilisateurs, réparti sur les autres courses --------------

reserved = ["Laurie", "Robert", "Julien"] + bordeaux_buddies.map { |b| b[:name] }

users.reject { |u| reserved.include?(u.first_name) }.each_with_index do |user, index|
  postcode = ALL_SPOTS.keys[index % ALL_SPOTS.keys.length]
  race = upcoming_races[index % upcoming_races.length]

  build_target(targets,
               user: user,
               race: race,
               hour: [2, 3, 3, 4].sample,
               minute: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].sample,
               postcode: postcode,
               spots: ALL_SPOTS)

  next unless index % 3 == 0

  build_target(targets,
               user: user,
               race: upcoming_races[(index + 5) % upcoming_races.length],
               hour: [2, 3, 4].sample,
               minute: [0, 10, 20, 30, 40, 50].sample,
               postcode: postcode,
               spots: ALL_SPOTS)
end

puts "✅ #{targets.count} objectifs créés au total"


# ============================================================
# INVITES
# ============================================================
# La validation du modèle interdit deux invitations entre les mêmes
# personnes, quel que soit le sens. On suit donc les paires déjà utilisées.
# ============================================================

puts "🤝 Création des invitations..."

invites = []
paired = Set.new

create_invite = lambda do |sender, target, status|
  pair = [sender.id, target.user_id].sort

  return nil if sender.id == target.user_id
  return nil if paired.include?(pair)

  invite = Invite.create!(user: sender, target: target, status: status)

  paired << pair
  invites << invite
  invite
end

# --- Laurie et Robert sont connectés à plusieurs buddies --------------------

laurie_accepted = [
  create_invite.call(find_user(users, "Alex"),   laurie_target, "accepted"),
  create_invite.call(find_user(users, "Clara"),  laurie_target, "accepted"),
  create_invite.call(find_user(users, "Emma"),   laurie_target, "accepted")
].compact

robert_accepted = [
  create_invite.call(find_user(users, "Hugo"),   robert_target, "accepted"),
  create_invite.call(find_user(users, "Nathan"), robert_target, "accepted")
].compact

# --- Quelques invitations en attente pour la démo ---------------------------

create_invite.call(find_user(users, "Chloé"),  laurie_target, "pending")
create_invite.call(find_user(users, "Maxime"), robert_target, "pending")

# --- Invitations aléatoires entre les autres --------------------------------

targets.reject { |t| [laurie_target, robert_target].include?(t) }.each do |target|
  candidates = users.reject do |user|
    user.id == target.user_id ||
      user == julien ||
      paired.include?([user.id, target.user_id].sort)
  end

  candidates.sample(rand(0..2)).each do |sender|
    create_invite.call(sender, target, ["pending", "accepted"].sample)
  end
end

puts "✅ #{invites.count} invitations créées"


# ============================================================
# CHATS
# ============================================================

puts "💬 Création des conversations..."

accepted_invites = invites.select { |invite| invite.status == "accepted" }

chats = accepted_invites.map do |invite|
  Chat.create!(
    invite: invite,
    title: invite.target.race.name
  )
end

puts "✅ #{chats.count} conversations créées"


# ============================================================
# MESSAGES
# ============================================================

puts "✉️  Création des messages..."

conversation = [
  "Salut ! Tu prépares aussi cette course ?",
  "Oui, j'ai commencé le plan il y a six semaines.",
  "Tu vises quel temps au final ?",
  "J'aimerais bien tenir l'allure jusqu'au bout cette fois.",
  "Ça te dirait une sortie longue ensemble ce week-end ?",
  "Carrément, samedi matin je suis libre.",
  "Tu cours plutôt le matin ou le soir ?",
  "Le matin, il fait beaucoup trop chaud l'après-midi.",
  "On se retrouve sur les quais alors ?",
  "Parfait, disons 8h devant le miroir d'eau.",
  "Tu tournes à combien de kilomètres par semaine ?",
  "Entre 40 et 45 en ce moment.",
  "Beau volume, ça va payer le jour J.",
  "J'espère ! Le fractionné commence à rentrer.",
  "On se cale ça pour la semaine prochaine.",
  "Ça marche, à samedi 🏃"
]

chats.each_with_index do |chat, chat_index|
  user_one = chat.invite.user
  user_two = chat.invite.target.user

  count = rand(4..10)
  start = rand(3..25).days.ago

  count.times do |i|
    sender = i.even? ? user_one : user_two
    sent_at = start + (i * rand(20..180)).minutes

    Message.create!(
      chat: chat,
      user: sender,
      content: conversation[i % conversation.length],
      created_at: sent_at,
      updated_at: sent_at
    )
  end

  # Une conversation sur trois reste non lue, pour voir les pastilles.
  next if chat_index % 3 == 0

  chat.update_columns(
    inviter_read_at: Time.current,
    invitee_read_at: Time.current
  )
end

puts "✅ #{Message.count} messages créés"


# ============================================================
# BUDDY RATINGS
# ============================================================

puts "👍 Création des évaluations..."

ratings = []

rate = lambda do |author, buddy, value|
  return if author.nil? || buddy.nil? || author == buddy
  return if BuddyRating.exists?(user: author, buddy: buddy)

  ratings << BuddyRating.create!(user: author, buddy: buddy, rating: value)
end

# --- Laurie : bien notée, quelques votes ------------------------------------

rate.call(find_user(users, "Alex"),   laurie,  1)
rate.call(find_user(users, "Clara"),  laurie,  1)
rate.call(find_user(users, "Emma"),   laurie,  1)
rate.call(find_user(users, "Hugo"),   laurie,  1)
rate.call(find_user(users, "Nathan"), laurie, -1)

# --- Robert : très bien noté ------------------------------------------------

rate.call(find_user(users, "Hugo"),   robert, 1)
rate.call(find_user(users, "Nathan"), robert, 1)
rate.call(find_user(users, "Chloé"),  robert, 1)
rate.call(find_user(users, "Maxime"), robert, 1)

# --- Laurie et Robert notent aussi leurs buddies ----------------------------

rate.call(laurie, find_user(users, "Alex"),  1)
rate.call(laurie, find_user(users, "Clara"), 1)
rate.call(robert, find_user(users, "Hugo"),  1)

# --- Les autres buddies du marathon reçoivent quelques avis -----------------

bordeaux_targets.each do |target|
  voters = users.reject { |u| u == target.user || u == julien }.sample(rand(2..4))

  voters.each { |voter| rate.call(voter, target.user, [1, 1, 1, -1].sample) }
end

puts "✅ #{ratings.count} évaluations créées"


# ============================================================
# RÉCAPITULATIF
# ============================================================

puts ""
puts "======================================"
puts "🎉 SEEDS TERMINÉS"
puts "======================================"
puts "👤 Users    : #{User.count}"
puts "🏃 Races    : #{Race.count}"
puts "🎯 Targets  : #{Target.count}"
puts "🤝 Invites  : #{Invite.count}"
puts "💬 Chats    : #{Chat.count}"
puts "✉️  Messages : #{Message.count}"
puts "👍 Ratings  : #{BuddyRating.count}"
puts "======================================"
puts ""
puts "🔐 Mot de passe : password"
puts ""
puts "🏁 #{bordeaux_marathon.name} — #{bordeaux_marathon.race_date.strftime('%d/%m/%Y')}"
puts ""
puts "   Laurie  (#{laurie.email})  → 3h45  depuis le 33000"
puts "   Robert  (#{robert.email})  → 3h45  depuis le 33200"
puts "   Alex    → 3h30   |  Chloé  → 3h35"
puts "   Hugo    → 3h40   |  Maxime → 3h40"
puts "   Clara   → 3h50   |  Emma   → 3h55"
puts "   Nathan  → 4h00"
puts ""
puts "   Julien  (#{julien.email}) → profil neuf, aucun objectif"
puts "   👉 À créer en démo : Marathon de Bordeaux Métropole → 3h45"
puts "======================================"
