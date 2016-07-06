require "yelp"
require 'pry'

class FindTheBestFood::YelpApi

  attr_reader :client, :restaurants, :locale, :result, :food, :location, :params

  def initialize(food, location)
    @client = Yelp::Client.new({ consumer_key: 'Jaece9RDbUKrTOqyY8BKWA',
                                consumer_secret: 'R5k8K7leYQcUYueOc1trD790LSY',
                                token: 'PdikQoKuDU9t4aW8WQ7Q0dmR2mjO24vK',
                                token_secret: 'CHEdmNqsXLTYAXtNw0ugLNX9SmQ'
                              })
   
    @locale = { cc: 'US', lang: 'en'}
    @food = food
    @location = location
    # restaurants_info
  end

  def params
    @params = { term: @food,
               sort: 2,
               category_filter: 'restaurants',
               radius_filter: 1500
             }
  end


  def restaurants_info
    results = @client.search(@location, self.params, @locale).businesses
  end


end

