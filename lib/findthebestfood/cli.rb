class FindTheBestFood::CLI

  def call
    Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
  end

end