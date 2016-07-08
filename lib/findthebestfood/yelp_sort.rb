
class FindTheBestFood::YelpSort

  attr_reader :yelp

  def self.find_by_yelp(food, location)
    @yelp = FindTheBestFood::YelpApi.new(food,location).restaurants_info
  end

end
