class Mechanic < ApplicationRecord
  has_many :repairs, dependent: :nullify

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
end