class Customer < ApplicationRecord
  has_many :bikes, dependent: :restrict_with_error
  has_many :repairs, through: :bikes

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
  validates :phone, presence: true
end