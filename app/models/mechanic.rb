class Mechanic < ApplicationRecord
  has_many :repairs, dependent: :nullify
  has_one :user, dependent: :restrict_with_error

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
end