class FindTheBestFood::CLI

  def call
    results = Google::Scraper.scrapRestaurantInfoWith(location:"manhattan, new york", food:"chinese food")
    # binding.pry
  end

end