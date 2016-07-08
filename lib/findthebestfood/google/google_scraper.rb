class Google::Scraper

	def self.scrapRestaurantInfoWith(location:, food:)
		Google::URIHelper.new.top10RestaurantInfoWith(location:location, food:food)
		# => [Restaurant objects]
	end

end