class FindTheBestFood::CLI
 


  def call
    puts Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
    puts FindTheBestFood::YelpSort.find_by_yelp('padthai', 'midtown west, manhattan')
    puts FindTheBestFood::Zagat.scrape('pad thai', 'midtown west')
  end



end

