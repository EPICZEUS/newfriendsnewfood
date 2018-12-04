class Group < ApplicationRecord
  has_many :messages
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :reservations
  has_many :restaurants, through: :reservations
end
