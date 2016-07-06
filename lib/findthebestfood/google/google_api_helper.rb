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


	end


end