class FindTheBestFood::CLI
  attr_reader :google, :yelp
  def call#(location:, food:)
  	# # sort(food, location)
  	results = sort("pasta", "midtown west, manhattan")
  	puts results
    binding.pry
  	# => [Restaurant objects] 
  end



  def sort(food, location)
    @google = Google::Scraper.scrapRestaurantInfoWith(location:location, food:food)
    @yelp = FindTheBestFood::YelpSort.find_by_yelp(food, location)

    # zagat = FindTheBestFood::Zagat.results(food, location)
    restaurants = []
    restaurants = @google + @yelp
    binding.pry
    results_to_users = {}  # => {name: {info}, name: {info}}
  	restaurants.each do |restaurant|
  		restaurant.name = restaurant.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
  		if results_to_users.keys.include?(restaurant.name)

        # name = restaurant.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
  			total_rating = results_to_users[restaurant.name][:rating] + restaurant.rating
  			results_to_users[restaurant.name][:rating] = total_rating / 2
        results_to_users[restaurant.name][:reviews] = restaurant.reviews if restaurant.reviews

  		else
        if in_all?(restaurant)
          weekday_text = "Unavailable"
          open_now = "Unavailable"
          if restaurant.opening_hours
            weekday_text = restaurant.opening_hours["weekday_text"]
            open_now = restaurant.opening_hours["open_now"]
          end
    			results_to_users[restaurant.name] = {
    				'phone': restaurant.phone,
    				'rating': restaurant.rating,
    				'address': restaurant.address, 
    				'price': restaurant.price, 
    				'reviews': restaurant.reviews, 
    				'opening_hours': weekday_text,
            'open_now': open_now
    			}
        end
  		end
  	end
    results_to_users.sort_by {|k, v| v[:rating]}.reverse.to_h
  end

  def in_all?(restaurant)
    in_google = false
    @google.each do |google_r|
      if restaurant.name == google_r.name
        in_google = true
      end
    end

    in_yelp = false
    @yelp.each do |yelp_r|
      if restaurant.name == yelp_r.name
        in_yelp = true
      end
    end

    in_google && in_yelp
  end
 
end

