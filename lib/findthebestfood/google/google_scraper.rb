class Google::Scraper

	def self.scrapRestaurantInfoWith(location:, food:)
		results = Google::URIHelper.new.top10RestaurantInfoWith(location:location, food:food)
		# binding.pry
	end

end