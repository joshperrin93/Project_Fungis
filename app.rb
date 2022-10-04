require "uri"
require "net/http"
require 'google_places'
require 'pp'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/restaurant_finder'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/index' do
    return erb(:index)
  end

  post '/index' do
    location = params{:location}
    p location
    @search = RestaurantFinder.new(location['location'])
    p @search
    @restaurants = @search.find
    p @restaurants
    return erb(:results)
  end

end


@client = GooglePlaces::Client.new('AIzaSyBKVLaoQMhqkYNmZRWlBRwHS_v1UiwIRTA')
@results = @client.spots_by_query('Pizza', :types => ['restaurant', 'food'])
# spot = @client.spots(-0.118092, 51.509865, :name => 'vegan', :types => 'restaurant')
# spot.each {|item| puts spot.name}
# plce = list.find {|item| item.}
puts @results

@results.map {|item| puts "Name: #{item.name}, \n Place ID: #{item.place_id}, \n Reviews: #{item.reviews}"}




