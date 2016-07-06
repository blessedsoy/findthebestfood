# require 'google_places'



# @client = GooglePlaces::Client.new("AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4")

# @client.spots_by_query('Pizza near Miami Florida', :types => ['restaurant', 'food'], :exclude => ['cafe', 'establishment'])



require 'google_places'

@client = GooglePlaces::Client.new('AIzaSyC1NNKu1rO9MK6lm3SuhhhEEmgJx3PEpU4')


@client.spots_by_query('Pizza near Midtown New York City', :types => ['restaurant', 'food']).each do |place|
 puts place
end