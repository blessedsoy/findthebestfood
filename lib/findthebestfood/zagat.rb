require 'nokogiri'
require 'pry'
require 'open-uri'


class FindTheBestFood::Zagat


  def self.scrape(food, location)
    @food = food
    @location = location
    front_url = "https://www.zagat.com/"
    type_of_food = "search/place?text=#{food.gsub(" ","+")}&rdr=1#filter/"
    
    case location
      when 'midtown west'
        location = "neighborhoods=West+30s%7CWest+40s%7CWest+50s"
      when "upper west" 
        location = "neighborhoods=West+60s%7CWest+70s%7CWest+80s%7CWest+90s"
      when "midtown east"
        location = "neighborhoods=East+40s%7CEast+50s"
      when "upper east"
        location = "neighborhoods=East+60s%7CEast+70s%7CEast+80s%7CEast+90s"
      when "chelsea" || "flatiron"
        location = "neighborhoods=Chelsea%7CFlatiron%7CMeatpacking+District%7CWest+30s"
      when "murray hill" || "gramercy"
        location = "neighborhoods=East+40s%7CGramercy+Park%7CNoMad%7CMurray+Hill"
      when "west village" || "greenwich village"
        location = "neighborhoods=Greenwich+Village%7CNoHo%7CWest+Village"
      when "soho" || "tribeca" || "chinatown" || "little italy" 
        location = "neighborhoods=Little+Italy%7CNolita%7CSoHo%7CTriBeCa"
      when "financial district" || "battery park city"
        location = "Battery+Park+City%7CFinancial+District&%7CSouth+Street+Seaport"
      when "lower east side" || "east village"
        location = "neighborhoods=East+Village%7CLower+East+Side"
      when "harlem" || "east harlem" || "morningside heights" 
        location = "neighborhoods=East+90s%7CEast+Harlem%7CHarlem%7CMorningside+Heights"
      else
        location = "neighborhoods=West+30s%7CWest+40s%7CWest+50s%7CWest+60s%7CWest+70s%7CWest+80s%7CWest+90s%7CEast+40s%7CEast+50s%7CEast+60s%7CEast+70s%7CEast+80s%7CEast+90s%7CChelsea%7CFlatiron%7CMeatpacking+District%7CGramercy+Park%7CNoMad%7CMurray+Hill%7CGreenwich+Village%7CNoHo%7CWest+Village%7CLittle+Italy%7CNolita%7CSoHo%7CTriBeCa%7CBattery+Park+City%7CFinancial+District&%7CSouth+Street+Seaport%7CEast+Village%7CLower+East+Side%7CEast+Harlem%7CHarlem%7CMorningside+Heights"
    end

      back_url = "&vertical=46&orderby=score_food&sort=desc&page=1"
      full_url = front_url+type_of_food+location+back_url

      doc = Nokogiri::HTML(open(full_url))
      restaurants = Hash.new { |hash, key| hash[key] = {} }

      doc.css("div.cases.js-search-results div.text-block").each do |results|
        results.css("h3").each do |name|
          restaurant_name = name.text
            results.css("div.info div.text-stats, span.i-number.i-number-red").each do |rating|
              restaurant_rating = (rating.text.to_i * 5 / 30).round(2)
                results.css("div.info div.text-stats, span.i-number").each do |cost|
                  restaurant_cost = cost.text if cost.text.include?('$')
                    restaurants[restaurant_name] = {rating: restaurant_rating, cost: restaurant_cost}
                end
            end
        end
      end
      restaurants = restaurants.sort_by {|restaurant, element| element[:rating]}
      results = {}
      restaurants.each do |restaurant|
        results[restaurant[0]] = restaurant[1]
      end
      results
  end
end