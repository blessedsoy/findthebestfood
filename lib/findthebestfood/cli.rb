class FindTheBestFood::CLI
  attr_reader :google, :yelp

  LOCATION = {
    1 => "Midtown West",
    2 => "Midtown East",
    3 => "Upper West Side",
    4 => "Upper East Side",
    5 => "Chelsea Flatiron",
    6 => "Murray Hill / Gramercy",
    7 => "West Village / Greenwinch Village",
    8 => "Soho / Tribeca / Chinatown",
    9 => "Financial District / Battery Park City",
    10 => "Lower East Side / East Village",
    11 => "Harlem / East Harlem / Morningside Heights"
  }

  def call
  	self.menu
  end

  def menu
    puts "
    Welcome to FindTheBestFood in NYC!
    "
    puts "What kind of food do you want?"
    food = gets.strip
    puts "Choose your location (1-11):\n
    1. Midtown West\n
    2. Midtown East\n
    3. Upper West Side\n
    4. Upper East Side\n
    5. Chelsea Flatiron\n
    6. Murray Hill / Gramercy\n
    7. West Village / Greenwinch Village\n
    8. Soho / Fribeca / Chinatown\n
    9. Financial District / Battery Park City\n
    10. Lower East Side / East Village\n
    11. Harlem / East Harlem / Morningside Heights"
    key = gets.strip.to_i
    location = LOCATION[key]
    puts "LOADING...........\n
    "

    final_results(food, location)
  end
    # best_choices = sort(food, location).sort {|a, b| b[1][:rating] <=> a[1][:rating] }[0..9].to_h #.max(10)
    
  def final_results(food, location)
    best_choices = sort(food, location)
    best_choices.each {|restaurant| 
      puts "  #{restaurant.name}:\n
         Address: #{restaurant.address}\n
         Phone: #{restaurant.phone}\n
         Rating: #{restaurant.rating}\n
         Reviews: #{restaurant.reviews}\n
         Open now: #{restaurant.open_now}
         "
         # binding.pry
          if restaurant.opening_hours != nil && restaurant.opening_hours.size > 0
            restaurant.opening_hours.each_with_index do |hour, index|
              if index == 0 
                puts "         Opening hours: #{hour}"
              else
                puts "                        #{hour}"
              end
            
            end
          else
            puts "         Opening hours: Unavailable"
          end

      puts "================================================================="
    }

  end

def sort(food, location)
    @google = Google::Scraper.scrapRestaurantInfoWith(location:location, food:food)
    @yelp = FindTheBestFood::Yelp.find_by_yelp(food:food, location:location)
    
    results = Restaurant.all
    results.sort {|a,b| b.rating <=> a.rating}[0..9]
end

  # def sort(food, location)
  #   @google = Google::Scraper.scrapRestaurantInfoWith(location:location, food:food)
  #   @yelp = FindTheBestFood::Yelp.find_by_yelp(food:food, location:location)
    # # zagat = FindTheBestFood::Zagat.results(food, location)
    # restaurants = []
    # restaurants = @google + @yelp


   #  results_to_users = {}  # => {name: {info}, name: {info}}
  	# restaurants.each do |restaurant|
  	# 	restaurant.name = restaurant.name.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
  	# 	if results_to_users.keys.include?(restaurant.name)

  	# 		total_rating = results_to_users[restaurant.name][:rating] + restaurant.rating
  	# 		results_to_users[restaurant.name][:rating] = (total_rating / 2).round(1)
   #      results_to_users[restaurant.name][:reviews] = restaurant.reviews if restaurant.reviews

  		# else


        # add_new_restaurant_to_hash(results_to_users, restaurant)
        # binding.pry
        # if in_all?(restaurant)
       #    weekday_text = []
       #    open_now = "Unavailable"
       #    if restaurant.opening_hours && restaurant.opening_hours.size > 0
           
       #      weekday_text = restaurant.opening_hours["weekday_text"]
       #      open_now = restaurant.opening_hours["open_now"]
       #    end
    			# results_to_users[restaurant.name] = {
    			# 	'phone': restaurant.phone,
    			# 	'rating': restaurant.rating,
    			# 	'address': restaurant.address, 
    			# 	'price': restaurant.price, 
    			# 	'reviews': restaurant.reviews, 
    			# 	'opening_hours': weekday_text,
       #      'open_now': open_now
    			# }
        # end
  # 		end
  # 	end
  #   results_to_users #return hashes of final results

  # end

  # def add_new_restaurant_to_hash(hash, restaurant)



  # weekday_text = []
  #         open_now = "Unavailable"
  #         if restaurant.opening_hours && restaurant.opening_hours.size > 0
           
  #           weekday_text = restaurant.opening_hours["weekday_text"]
  #           open_now = restaurant.opening_hours["open_now"]
  #         end
  #         hash[restaurant.name] = {
  #           'phone': restaurant.phone,
  #           'rating': restaurant.rating,
  #           'address': restaurant.address, 
  #           'price': restaurant.price, 
  #           'reviews': restaurant.reviews, 
  #           'opening_hours': weekday_text,
  #           'open_now': open_now
  #         }
  # end

#   def in_all?(restaurant)

#     in_google = false
#     @google.each do |google_r|
#       if restaurant.name == google_r.name
#         # binding.pry
#         in_google = true
#       end
#     end

#     in_yelp = false
#     @yelp.each do |yelp_r|
#       if restaurant.name == yelp_r.name
#         # binding.pry
#         in_yelp = true
#       end
#     end

#     in_google || in_yelp  
#   end
 
end

