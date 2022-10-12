require 'google_places'
require_relative '../.api_key.rb'

class RestaurantFinder
    def initialize(location, place_id)
        @location = location
        @place_id = place_id
        @client = GooglePlaces::Client.new($api_key)
    end

    def find
        results = @client.spots_by_query('Vegan ' + @location, :types => ['restaurant', 'food'])
        return results.map {|item| [item.name, item.formatted_address, item.rating, item.photos, item.place_id, item.lat, item.lng]}
    end

    def find_name
        results = @client.spots_by_query('Vegan ' + @location, :types => ['restaurant', 'food'])
        return results.map {|item| [item.name]}
    end

    def restaurant_info
        place = @client.spot(@place_id)
        return place
    end

    def info_bubble(array)
        info_bubble = []
        array.each do |item|
            hash = {
                "name" => item[0],
                "lat" => item[5],
                "lng" => item[6],
                "address" => item[1]
            }
            info_bubble << hash
        end
        return info_bubble
    end
end

# restaurant = RestaurantFinder.new('London', '')
# p restaurant.lat_long