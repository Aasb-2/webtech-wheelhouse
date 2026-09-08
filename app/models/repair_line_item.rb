class RepairLineItem < ApplicationRecord
  belongs_to :repair
  belongs_to :service_item

  validates :price_charged, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
