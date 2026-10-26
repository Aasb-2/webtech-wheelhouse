class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  enum :role, { owner: "owner", mechanic: "mechanic", counter: "counter" }, default: :counter

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end