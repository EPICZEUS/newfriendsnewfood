class Group < ApplicationRecord
	validates :name, presence: true
	
  has_many :messages, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :reservations, dependent: :destroy
  has_many :restaurants, through: :reservations

  def potential_restaurants
  	rests = self.users.map(&:group_searches).flatten.select { |e| self.users.include?(e.user) }.map(&:restaurant)

  	rests.delete_if { |e| rests.count(e) == 1 }.uniq
  end

  def user_ids=(ids)
  	ids.each { |e| self.user_groups << UserGroup.create(user_id: e, group_id: self.id) }
  end
end
