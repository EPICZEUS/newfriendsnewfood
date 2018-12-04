class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :groups, through: :reservations

  def self.search(params)
  	req = {
  		'user-key': '39f051dd5468fa7441192f00e9dff87b',
  		entity_type: 'city',
  		entity_id: 280,
  		accept: :json
  	}

  	if params[:q]
  		req[:q] = params[:q]
  		req[:cuisines] = params[:cuisines] if params[:cuisine]
  	end

  	res = RestClient.get('https://developers.zomato.com/api/v2.1/search', req)

  	data = JSON.parse(res.body)

  	self.find_or_create_from_api(data[:restaurants])
  end

  def self.find_or_create_from_api(arr)
  	arr.map { |e| self.find_or_create_by(restaurant_params(arr[:restaurant])) }
  end

  private

  def restaurant_params(params)
  	data = {}

  	data[:name] = params[:name]
  	data[:location] = params[:location][:locality]
  	data[:cuisine] = params[:cuisines].split(', ').first
  	data[:rating] = params[:user_rating][:aggregate_rating]
  	data[:price] = params[:price_range]

  	data.permit(:name, :location, :cuisine, :rating, :price)
end
