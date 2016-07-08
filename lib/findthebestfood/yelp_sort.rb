
class FindTheBestFood::YelpSort

  def self.find_by_yelp(food, location)
    yelp = FindTheBestFood::YelpApi.new(food, location).restaurants_info
    # @restaurants = Hash.new{|k, v| k[v] = {}}
    @restaurants = Hash.new({})

    yelp.each do |place| 
      @restaurants[place.name] = {
      :review_count => place.review_count,
      :rating => place.rating,
      :phone => place.phone
      }
    end

    @restaurants = @restaurants.sort_by {|restaurant, element| element[:rating]}.reverse
    results = {}
    
    @restaurants.each do |restaurant|
      results[restaurant[0]] = restaurant[1]
    end
      results
  end
end
