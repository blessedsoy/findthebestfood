class FindTheBestFood::CLI

  def call
    puts FindTheBestFood::YelpSort.find_by_yelp('pad thai', 'midtown west, manhattan')

    results = Google::Scraper.scrapRestaurantInfoWith(location:"midtown west, manhattan", food:"pad thai")
    # binding.pry
    puts results
        puts FindTheBestFood::Zagat.results('pad thai', 'midtown west')
  end

  # def sort(food, location)
  #   FindTheBestFood::YelpSort.find_by_yelp(food, location)
  #   FindTheBestFood::Zagat.results(food, location)
  #   Google::Scraper.scrapRestaurantInfoWith(location:location, food:food)
  #   array = []
  # end

end

