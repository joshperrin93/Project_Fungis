require 'google_maps_service'
require_relative '../.api_key'

class MapFinder 
    def initialize
     puts $api_key 
    # Setup API keys
     @gmaps = GoogleMapsService::Client.new(key: $api_key)
  end
    
    def showMap
      geocode_result = @gmaps
    #   puts geocode_result.first[:types]
        return geocode_result
    
    end
end

