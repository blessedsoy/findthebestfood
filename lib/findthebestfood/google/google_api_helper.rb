class Google::URIHelper

	CLIENT_KEY = 'AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4'

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
			# binding.pry
			name = restaurant.name
			rh = {}
			rh[name] = {}
			rh[name][:rating] = restaurant.rating || 0
			rh[name][:price] = restaurant.price_level || 0
			rh[name][:address] = restaurant.formatted_address || ""
			rh[name][:phone] = restaurant.formatted_phone_number || ""
			rh[name][:opening_hours] = {
				'open_now': restaurant.opening_hours[:open_now],
				'weekday': restaurant.opening_hours[:weekday_text] # => []
			}
			rh
		end
	end


end