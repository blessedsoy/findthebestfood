class FindTheBestFood::CLI

  def call#(location:, food:)
  	# sort(food, location)
  	results = sort("pad thai", "midtown west, manhattan")
  	binding.pry
  	# => [Restaurant objects] 
  end



  def sort(food, location)
    # yelp = FindTheBestFood::YelpSort.find_by_yelp(food, location)
    google = Google::Scraper.scrapRestaurantInfoWith(location:location, food:food)
    # zagat = FindTheBestFood::Zagat.results(food, location)
    restaurants = []
    restaurants = google

    results_to_users = {}  # => {name: {info}, name: {info}}
	restaurants.each do |restaurant|
		
		if results_to_users.keys.include?(restaurant.name)
			total_rating = results_to_users[restaurant.name][:rating] + restaurant.rating
			results_to_users[restaurant.name][:rating] = total_rating / 2
		else
			results_to_users[restaurant.name] = {
				'phone': restaurant.phone,
				'rating': restaurant.rating,
				'address': restaurant.address, 
				'price': restaurant.price, 
				'reviews': restaurant.reviews, 
				'opening_hours': restaurant.opening_hours
			}
		end
	end

end
 
>>>>>>> f51b7ae0238f4ab9bb8b9997f17fb6db1f388c43

end

