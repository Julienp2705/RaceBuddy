class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: { message: "Écris un message avant de l'envoyer" }, length: { minimum: 2, message: "Ton message doit contenir au moins 2 caractères" }
end
