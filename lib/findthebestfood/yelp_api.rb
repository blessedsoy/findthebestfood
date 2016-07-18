require "yelp"
require 'pry'
require 'json'

class FindTheBestFood::YelpApi
  file = File.read('info.json')
  data = JSON.parse(file)

  CONSUMER_KEY = data['Client']['consumer_key']
  CONSUMER_SECRET = data['Client']['consumer_secret']
  TOKEN = data['Client']['token']
  TOKEN_SECRET = data['Client']['token_secret']

  attr_reader :client, :restaurants, :locale, :result, :food, :location

  def initialize(food, location)
    
    @client = Yelp::Client.new({ consumer_key: CONSUMER_KEY,
                                consumer_secret: CONSUMER_SECRET,
                                token: TOKEN,
                                token_secret: TOKEN_SECRET
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

