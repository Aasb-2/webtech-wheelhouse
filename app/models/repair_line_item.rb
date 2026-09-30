class RepairLineItem < ApplicationRecord
  belongs_to :repair
  belongs_to :service_item

  scope :by_name, -> { order(:name) }

  validates :price_charged, presence: true, numericality: { greater_than: 0 }

  validate :price_error_names_the_service

private

def price_error_names_the_service
  return unless errors[:price_charged].any?
  return unless service_item

  errors.delete(:price_charged)
  errors.add(:base, "#{service_item.name}: price charged must be greater than 0")
end
end