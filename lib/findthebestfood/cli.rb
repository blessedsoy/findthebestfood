class FindTheBestFood::CLI

  def call
     puts FindTheBestFood::YelpSort.find_by_yelp('padthai', 'midtown west, manhattan')
     puts FindTheBestFood::Zagat.scrape('pad thai', 'midtown west')
    results = Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
    puts results
  end



end

