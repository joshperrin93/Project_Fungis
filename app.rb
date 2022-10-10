require 'sinatra/base'
require 'sinatra/reloader'
require "uri"
require "net/http"
require 'google_places'
require 'pp'
require 'geocoder'
require_relative 'lib/database_connection'
require_relative 'lib/restaurant_finder'
require_relative 'lib/database_connection'
require_relative 'lib/user'
require_relative 'lib/user_repository'
require_relative 'lib/favorites'
require_relative 'lib/favorites_repository'



DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    enable :sessions
  end

  get '/index' do
    puts logged_in?
    return erb(:index)
  end

  post '/index' do
    user_repo = UserRepository.new
    email = params[:email]
    password = params[:password]
    user = user_repo.find_by_email(email)

    if user == false
      # If user doesn't exist according to #find_by_email
      return erb(:login_failure)
    elsif user.password == password && user.email == email
      # If user exists, save user.id to current session, save user.name to current session
      session[:user_id] = user.id
      session[:user_name] = user.name
      return redirect("/index")
    elsif user.password != password && user.email == email
      return erb(:login_failure)
    end
  end

  get '/signup_success' do
    return erb(:signup_success)
  end

  post '/results' do
    location = params[:location]
    search = RestaurantFinder.new(location, '')
    restaurants = search.find
    results = Geocoder.search(location)
    @centre = results.first.coordinates
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
    # saved_restaurants = []
    # session[:saved_restaurants] = place_id
    # saved_restaurants.push(place_id)
    session[:place_id] = place_id
    search = RestaurantFinder.new('', place_id)
    @place_info = search.restaurant_info

    session[:name] = @place_info.name
      # p session[:place_id]
      # p session[:user_id]

    return erb(:more_info)

  end

  get '/signup' do
    return erb(:signup)
  end

  get '/login' do
    return erb(:login)
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  post '/signup_success' do
    @new_user = User.new
    @new_user.name = params[:name]
    @new_user.password = params[:password]
    @new_user.email = params[:email]
    add_new_user = UserRepository.new
    add_new_user.create(@new_user)
      return erb(:signup_success)
  end

  get '/favorite_restaurants' do
    repo = Favorites_Repository.new
    @all_favorites =  repo.all
    return erb(:favorite_restaurants)
  end

  post '/favorite_restaurants' do
      favorite = Favorites.new
      repo = Favorites_Repository.new
      favorite.place_id = session[:place_id]
      favorite.name = session[:name]
      favorite.user_id =  session[:user_id] 
      @new_favorite = repo.create(favorite)
      @all_favorites =  repo.all
      return erb(:favorite_restaurants)

  end

  private

  def sort_by_rating(arg)
    return arg.sort_by!{|restaurant| [restaurant[2]]}.reverse!
  end

  helpers do

  def logged_in?
    if session[:user_id] == nil
      return false  
   else
      return true
   end 
   end
  end




end