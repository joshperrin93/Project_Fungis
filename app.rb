require 'sinatra/base'
require 'sinatra/reloader'
require "uri"
require "net/http"
require 'google_places'
require 'pp'
require_relative 'lib/database_connection'
require_relative 'lib/restaurant_finder'
require_relative 'lib/database_connection'
require_relative 'lib/user'
require_relative 'lib/user_repository'


DatabaseConnection.connect


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
    location = params[:location]
    search = RestaurantFinder.new(location, '')
    restaurants = search.find
    @sorted_restaurants = sort_by_rating(restaurants)
    @coordinates = []
    @sorted_restaurants.each {|restaurant| 
    @coordinates.push([restaurant[5], restaurant[6]])
}
    # @coordinates = [{"lat" =>51.5000, "lng" => -0.3333}, {"lat" => 51.509865, "lng" => -0.118092}, {"lat" => 51.485093, "lng" => -0.174936}]
    return erb(:results)
  end

  get '/index/:place_id' do
    place_id = params[:place_id]
    search = RestaurantFinder.new('', place_id)
    @place_info = search.restaurant_info
    return erb(:more_info)
  end

  get '/signup' do
    return erb(:signup)
  end


  post '/signup' do
    new_user = User.new
    new_user.name = params[:name]
    new_user.password = params[:password]
    new_user.email = params[:email]
    add_new_user = UserRepository.new
    add_new_user.create(new_user)
   return erb(:index)
  end

  private

  def sort_by_rating(arg)
    return arg.sort_by!{|restaurant| [restaurant[2]]}.reverse!
  end


end




