# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative '../config/environment'
require 'rest-client'
require 'JSON'

Cuisine.destroy_all

data = RestClient.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=280", {'user-key': '39f051dd5468fa7441192f00e9dff87b', accept: :json})

data = JSON.parse(data.body)

data.each do |e| 
	cuisine = e[:cuisine]

	Cuisine.create(name: cuisine[:cuising_name], cuisine_id: cuisine[:cuising_id])
end