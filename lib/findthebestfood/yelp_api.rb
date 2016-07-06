
require 'yelp'
require 'pry'

class FindTheBestFood::YelpApi

  attr_reader :client, :restaurants, :locale

  def self.start(client = nil, restaurants = nil, locale = nil)
    client = Yelp::Client.new({ consumer_key: 'Jaece9RDbUKrTOqyY8BKWA',
                                consumer_secret: 'R5k8K7leYQcUYueOc1trD790LSY',
                                token: 'PdikQoKuDU9t4aW8WQ7Q0dmR2mjO24vK',
                                token_secret: 'CHEdmNqsXLTYAXtNw0ugLNX9SmQ'
                              })
    restaurants = Hash.new{|k, v| k[v] = {}}
    locale = { cc: 'US', lang: 'en'}
  end


  def self.params
    params = { term: 'Pad Thai',
               sort: 2,
               category_filter: 'restaurants',
               radius_filter: 1500
             }
  end


  def self.search
    client.search('Midtown West, nyc', @params, @locale).businesses.each do |place|
  restaurants[place.name] = {
      :review_count => place.review_count,
      :rating => place.rating,
      :phone => place.phone
  }
    end
  end

  def self.sort
   restaurants.sort_by {|restaurant, element| element[:rating]}.reverse
   result = restaurants.sort_by {|restaurant, element| element[:review_count]}.reverse
   puts result
  end

end

