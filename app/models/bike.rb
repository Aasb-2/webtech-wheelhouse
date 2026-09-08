class Bike < ApplicationRecord
  belongs_to :customer
  has_many :repairs, dependent: :restrict_with_error

  validates :model, presence: true
  validates :serial_number, presence: true, uniqueness: true
end