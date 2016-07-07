class FindTheBestFood::CLI

  def call
     FindTheBestFood::YelpSort.find_by_yelp('padthai', 'midtown west, manhattan')
     FindTheBestFood::Zagat.scrape('pad thai', 'midtown west')
    results = Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
    # binding.pry
  end



end

