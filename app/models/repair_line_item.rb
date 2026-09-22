class RepairLineItem < ApplicationRecord
  belongs_to :repair
  belongs_to :service_item

  scope :by_name, -> { order(:name) }

  validates :price_charged, presence: true, numericality: { greater_than: 0 }
end