class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, confirmation: true
	validates :password_confirmation, presence: true

  has_many :messages
  has_many :user_groups, dependent: :destroy
  has_many :group_searches, dependent: :destroy
  has_many :groups, through: :user_groups

  before_save :defaults

  private

  def defaults
  	!self.img_url.empty? || self.img_url = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png"
  end
end
