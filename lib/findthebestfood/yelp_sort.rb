
class FindTheBestFood::YelpSort

  def self.find_by_yelp(food, location)
    yelp = FindTheBestFood::YelpApi.new(food, location).restaurants_info
    @restaurants = Hash.new{|k, v| k[v] = {}}
    yelp.each do |place| 
      @restaurants[place.name] = {
      :review_count => place.review_count,
      :rating => place.rating,
      :phone => place.phone
     }
    end
    final_results = @restaurants.sort_by {|restaurant, element| element[:review_count]}.reverse
  end

end
