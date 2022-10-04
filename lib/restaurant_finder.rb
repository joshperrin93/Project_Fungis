require 'google_places'
require_relative '../.api_key.rb'

class RestaurantFinder
    def initialize(location)
        @location = location
        @client = GooglePlaces::Client.new($api_key)
    end

    def find
        @results = @client.spots_by_query('Vegan ' + @location, :types => ['restaurant', 'food'])
        # spot = @client.spots(-0.118092, 51.509865, :name => 'vegan', :types => 'restaurant')
        return @results.map {|item| [item.name, item.formatted_address, item.rating, item.photos]}
    end
    # def find_id
    #     @results = @client.spots_by_query('Vegan ' + @location, :types => ['restaurant', 'food'])
    #     # spot = @client.spots(-0.118092, 51.509865, :name => 'vegan', :types => 'restaurant')
    #     return @results
    # end
end

restaurant = RestaurantFinder.new('London')
p restaurant.find