class User < ApplicationRecord
	validates :name, presence: true
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: true

  has_many :messages
  has_many :user_groups
  has_many :groups, through: :user_groups
end
