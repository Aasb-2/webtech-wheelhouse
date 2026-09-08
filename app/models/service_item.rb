class ServiceItem < ApplicationRecord
  has_many :repair_line_items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :current_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end