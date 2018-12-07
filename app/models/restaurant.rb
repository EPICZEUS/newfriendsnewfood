class Restaurant < ApplicationRecord
  has_many :reservations
  has_many :group_searches
  has_many :users, through: :group_searches
  has_many :groups, through: :reservations

  def self.search(params)
  	req = {
  		'user-key': '39f051dd5468fa7441192f00e9dff87b',
  		params: {
  			entity_type: 'city',
  		  entity_id: 280
  		}
  	}

  	unless params[:q] || params[:cuisine]
  		return []
  	end

  	req[:params][:q] = params[:q]
		req[:params][:cuisines] = params[:cuisine]

  	res = RestClient.get('https://developers.zomato.com/api/v2.1/search', req)

  	data = JSON.parse(res)

  	params[:result_count] = data["results_shown"]

  	self.find_or_create_from_api(data["restaurants"])
  end

  def self.find_or_create_from_api(arr)
  	arr.map { |e| self.find_or_create_by(restaurant_params(e["restaurant"])) }
  end

  private

  def self.restaurant_params(params)
  	data = ActionController::Parameters.new({})

  	data[:name] = params["name"]
  	data[:location] = params["location"]["locality"]
  	data[:cuisine] = params["cuisines"].split(', ').first
  	data[:rating] = params["user_rating"]["aggregate_rating"]
  	data[:price] = params["price_range"]
  	data[:url] = params["url"]

  	data.permit(:name, :location, :cuisine, :rating, :price, :url)
  end
end
# byebug