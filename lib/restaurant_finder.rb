require 'google_places'
require './api_key.rb'

class RestaurantFinder
    def initialize(location)
        @location = location
        @client = GooglePlaces::Client.new($api_key)
    end

    def find
        @results = @client.spots_by_query('Vegan ' + @location, :types => ['restaurant', 'food'])
        # spot = @client.spots(-0.118092, 51.509865, :name => 'vegan', :types => 'restaurant')
        # spot.each {|item| puts spot.name}
        # plce = list.find {|item| item.}
        # puts @results

        return @results.map {|item| item.name}
    end
end

restaurant = RestaurantFinder.new('London')
p restaurant.find