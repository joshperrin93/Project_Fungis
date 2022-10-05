require 'sinatra/base'
require 'sinatra/reloader'
require "uri"
require "net/http"
require 'google_places'
require 'pp'
require_relative 'lib/database_connection'
require_relative 'lib/restaurant_finder'
require_relative 'lib/google-map'

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
    @MapFinder = MapFinder.new("hello")
    return erb(:results)
  end

end






