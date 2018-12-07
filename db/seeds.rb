# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative '../config/environment'

Group.destroy_all
User.destroy_all
Cuisine.destroy_all
Restaurant.destroy_all

data = RestClient.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=280", {'user-key': '39f051dd5468fa7441192f00e9dff87b'})
data = JSON.parse(data)

# byebug
data["cuisines"].each do |e|
	# byebug
	cuisine = e["cuisine"]

	Cuisine.create(name: cuisine["cuisine_name"], cuisine_id: cuisine["cuisine_id"])
end

User.create(name: "Sam", username: "EPICZEUS", password: "admin5340", password_confirmation: "admin5340", age: 21, bio: "Love to eat all the foods!", img_url: "")
User.create(name: "Gabby", username: "gabby12345", password: "admin5340", password_confirmation: "admin5340", age: 28, bio: "Here to have fun and eat tasty things.", img_url: "")