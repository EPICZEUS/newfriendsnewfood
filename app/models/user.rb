class User < ApplicationRecord
	validates :username, uniqueness: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true

  has_many :messages
  has_many :user_groups
  has_many :groups, through: :user_groups
end
