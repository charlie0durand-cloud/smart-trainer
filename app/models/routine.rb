class Routine < ApplicationRecord
  belongs_to :user
  has_many :exercice, dependent: :destroy
  validates :name, presence: true
end
