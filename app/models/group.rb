class Group < ApplicationRecord
  has_many :messages
  has_many :users, through: :messages
  has_many :reservations
  has_many :restaurants, through: :reservations
end
