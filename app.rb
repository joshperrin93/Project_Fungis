require 'sinatra/base'
require 'sinatra/reloader'
require "uri"
require "net/http"
require 'google_places'
require 'pp'
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
    @search = RestaurantFinder.new(location['location'])
    @restaurants = @search.find
    @sorted_restaurants = sort_by_rating(@restaurants)
    @sorted_restaurants.reverse!
    return erb(:results)
  end

  private

  def sort_by_rating(arg)
    return arg.sort_by!{|restaurant| [restaurant[2]]}
  end

end







