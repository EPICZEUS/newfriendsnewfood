class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :groups, through: :reservations
end
