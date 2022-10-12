require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
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
require_relative 'lib/review'
require_relative 'lib/review_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    enable :sessions
  end

  get "/" do
    return erb(:test)
  end

  get '/index' do
    return erb(:index)
  end

  post '/index' do
    user_repo = UserRepository.new
    email = params[:email]
    password = params[:password]
    user = user_repo.find_by_email(email)

    if user == false
      # If user doesn't exist according to #find_by_email
      flash[:error] = "Email does not exist, go to sign up page or use another email."
      redirect '/login'
    elsif user.password == password && user.email == email
      # If user exists, save user.id to current session, save user.name to current session
      session[:user_id] = user.id
      session[:user_name] = user.name
      return redirect("/index")
    elsif user.password != password && user.email == email
      flash[:error] = "Incorrect password"
      redirect '/login'
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
    @info_bubbles = search.info_bubble(@sorted_restaurants)
    return erb(:results)
  end

  get '/index/:place_id' do
    repo = ReviewRepository.new
    place_id = params[:place_id]
    session[:place_id] = place_id
    search = RestaurantFinder.new('', place_id)
    @place_info = search.restaurant_info
    session[:name] = @place_info.name
    all_reviews = repo.all
    @reviews_for_place = all_reviews.select {|review| review.place_id == session[:place_id]}
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
    add_new_user = UserRepository.new
    all_users = add_new_user.all

    all_users.each do |user|
      if user.email.include? params[:email]
        return erb(:login)
      end
    end

    @new_user.name = params[:name]
    @new_user.password = params[:password]
    @new_user.email = params[:email]
    add_new_user.create(@new_user)
    return erb(:signup_success)
  end

  get '/favorite_restaurants' do
    repo = Favorites_Repository.new
    user = session[:user_id]
    @all_favorites = repo.user_favorite(user)
    return erb(:favorite_restaurants)
  end

  post '/favorite_restaurants' do
      favorite = Favorites.new
      repo = Favorites_Repository.new
      favorite.place_id = session[:place_id]
      favorite.name = session[:name]
      favorite.user_id =  session[:user_id] 
      @new_favorite = repo.create(favorite)
      if @new_favorite == false
        flash[:error] = "Already liked this restaurant"
        search = RestaurantFinder.new('', favorite.place_id)
        @place_info = search.restaurant_info
        repo = ReviewRepository.new
        all_reviews = repo.all
        @reviews_for_place = all_reviews.select {|review| review.place_id == session[:place_id]}
        return erb(:more_info)
      else 
        @all_favorites =  repo.user_favorite(favorite.user_id)
        return erb(:favorite_restaurants)
      end
  end

  post '/index/:place_id' do
    place_id = params[:place_id]
    search = RestaurantFinder.new('', place_id)
    @place_info = search.restaurant_info
    review = Review.new
    repo = ReviewRepository.new
    time = Time.new
    review.comment = params[:review]
    review.rating = params[:rating]
    review.place_id = params[:place_id]
    review.date_posted = time.inspect
    review.user_id = session[:user_id]
    review.user_name = session[:user_name]
    repo.create(review)
    redirect "/index/#{session[:place_id]}"
end

  private

  def sort_by_rating(arg)
    return arg.sort_by!{|restaurant| [restaurant[2]]}.reverse!
  end

  def logged_in?
    if session[:user_id] == nil
      return false  
    else
      return true
    end 
  end
end