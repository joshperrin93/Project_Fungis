require 'sinatra/base'
require 'sinatra/reloader'
require "uri"
require "net/http"
require 'google_places'
require 'pp'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

get "/" do
    return erb(:index)
end
 
end

    
@client = GooglePlaces::Client.new('AIzaSyBKVLaoQMhqkYNmZRWlBRwHS_v1UiwIRTA')
@results = @client.spots_by_query('Pizza', :types => ['restaurant', 'food'])
# spot = @client.spots(-0.118092, 51.509865, :name => 'vegan', :types => 'restaurant')
# spot.each {|item| puts spot.name}
# plce = list.find {|item| item.}
puts @results

@results.map {|item| puts "Name: #{item.name}, \n Place ID: #{item.place_id}, \n Reviews: #{item.reviews}"}




