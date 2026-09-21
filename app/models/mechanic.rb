class Mechanic < ApplicationRecord
  has_many :repairs

  validates :name, presence: true
end