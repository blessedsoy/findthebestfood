class Google::URIHelper

	CLIENT_KEY = 'AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4'
	DETAIL_URI = "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4&placeid="

	attr_reader :client, :restaurants, :location, :food

	def initialize
		@client = GooglePlaces::Client.new('AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4')
	end


	def top10RestaurantInfoWith(location:, food:)
		@location = location
		@food = food
		results = _requestTop10RestaurantInfo
	end

private
	def _requestTop10RestaurantInfo
		results = @client.spots_by_query(@location, :types => ['restaurant', @food])
											.sort {|a, b| b[:rating] <=> a[:rating]}[1..10]
		_parseRestaurantInfo(results)
	end

	def _parseRestaurantInfo(restaurants)
		restaurants.collect do |restaurant|
			_generateRestaurantInfoHash(restaurant)
		end
	end

	def _getRestaurantDetailWith(place_id)
		# binding.pry
		request_uri = DETAIL_URI + place_id
		resp = Net::HTTP.get_response(URI.parse(request_uri))
		body = JSON.parse(resp.body)
		body['result']
	end

	def _generateRestaurantInfoHash(restaurant)
		name = restaurant.name
		rh = {}
		rh[name] = {}
		rh[name][:rating] = restaurant.rating || 0
		rh[name][:price] = restaurant.price_level || 0
		rh[name][:address] = restaurant.formatted_address || ""
		detail = _getRestaurantDetailWith(restaurant.place_id)
		rh[name][:phone] = detail['formatted_phone_number']
		# rh[name][:reviews] = detail['reviews'].count 
		detail['opening_hours'] ? rh[name][:opening_now] = detail['opening_hours']['open_now'] : rh[name][:opening_now] = ""
		rh

	end


end