class Exercice < ApplicationRecord
  belongs_to :chat
  belongs_to :routine, optional: true
end
