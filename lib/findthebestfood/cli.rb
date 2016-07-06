class FindTheBestFood::CLI
 


  def call
    Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
    puts FindTheBestFood::YelpSort.find_by_yelp('padthai', 'midtown west, manhattan')

end

end