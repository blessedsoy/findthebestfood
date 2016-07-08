require "yelp"
require 'pry'

class FindTheBestFood::YelpApi

  attr_reader :client, :restaurants, :locale, :result, :food, :location

  def initialize(food, location)
    @client = Yelp::Client.new({ consumer_key: 'Jaece9RDbUKrTOqyY8BKWA',
                                consumer_secret: 'R5k8K7leYQcUYueOc1trD790LSY',
                                token: 'PdikQoKuDU9t4aW8WQ7Q0dmR2mjO24vK',
                                token_secret: 'CHEdmNqsXLTYAXtNw0ugLNX9SmQ'
                              })
   
    @locale = { cc: 'US', lang: 'en'}
    @food = food
    @location = location
  end

  def params
    @params = { term: @food,
               sort: 2,
               category_filter: 'restaurants',
               radius_filter: 1500
             }
  end


  def restaurants_info
    yelp = @client.search(self.location+", manhattan", self.params, locale).businesses
    # binding.pry
    sort_yelp(yelp)
  end

  def sort_yelp(data)    
    result = data.collect do |place| 
      self.each_restaurant(place)
    end
    result.sort {|a,  b| b.rating <=> a.rating}
  end

  def each_restaurant(place)

    restaurant = Hash.new({})
    restaurant[:name] = place.name
    restaurant[:reviews] = place.review_count
    restaurant[:rating] = place.rating
    restaurant[:phone] = place.phone
    restaurant[:address] = place.location.display_address[0]
 
    yelp_restaurant = Restaurant.new(restaurant)

  end

end

