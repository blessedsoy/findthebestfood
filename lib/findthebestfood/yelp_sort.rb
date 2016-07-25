
class FindTheBestFood::Yelp

  attr_reader :food, :location

  def self.find_by_yelp(food:, location:)
    @yelp = FindTheBestFood::YelpApi.new(food:food,location:location).restaurants_info
  end

end
