require 'json'

class Google::URIHelper

	file = File.read('info.json')
	data = JSON.parse(file)
	CLIENT_KEY = data["CLIENT_KEY"][0]
	DETAIL_URI = "https://maps.googleapis.com/maps/api/place/details/json?key=#{CLIENT_KEY}&placeid="

	attr_reader :client, :restaurants, :location, :food

	def initialize
		@client = GooglePlaces::Client.new(CLIENT_KEY)
	end


	def top10RestaurantInfoWith(location:, food:)
		@location = location
		@food = food
		_requestTop10RestaurantInfo # => [Restaurant objects]
	end

private
	def _requestTop10RestaurantInfo
		# binding.pry
		results = self.client.spots_by_query(self.food + ", " + self.location+" ,manhattan", :types => ['restaurant', 'food'])
		results.delete_if {|r| r.rating == nil }

		results.sort {|a, b| b.rating <=> a.rating}

		# binding.pry
		_parseRestaurantInfo(results)
	end

	def _parseRestaurantInfo(restaurants)
		restaurants.collect do |restaurant|
			_generateRestaurantInfoHash(restaurant) # => Restaurant object
		end
		# => [Restaurant objects]
	end


	def _generateRestaurantInfoHash(restaurant)
		rh = {}
		rh[:name] = restaurant.name
		rh[:rating] = restaurant.rating || 0
		rh[:price_level] = restaurant.price_level || 0
		rh[:address] = restaurant.formatted_address || ""
		detail = _getRestaurantDetailWith(restaurant.place_id)
		# binding.pry
		rh[:phone] = detail['formatted_phone_number'] || 0 
		rh[:opening_hours] = detail['opening_hours'] || []

		restaurant = Restaurant.new(rh)
	end

		def _getRestaurantDetailWith(place_id)
			# binding.pry
			request_uri = DETAIL_URI + place_id
			# binding.pry
			resp = Net::HTTP.get_response(URI.parse(request_uri))
			body = JSON.parse(resp.body)
			body['result']
		end


end