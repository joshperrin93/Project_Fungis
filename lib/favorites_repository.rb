require_relative 'favorites'
require_relative 'database_connection'

class Favorites_Repository
   
    def all
        @favorites = []
        sql = 'SELECT * FROM favourites'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
            favorite = Favorites.new
            favorite.id = record['id'].to_i
            favorite.place_id = record['place_id']
            favorite.user_id = record['user_id']
            favorite.name= record['name']

            @favorites << favorite
        end
    return @favorites
    end

    def user_favorite(user_session_id)
      @favorites = []
      
      sql = 'SELECT * FROM favourites WHERE user_id = $1;'
      sql_params = [user_session_id]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      result_set.each do |record|
        favorite = Favorites.new
        favorite.id = record['id'].to_i
        favorite.place_id = record['place_id']
        favorite.user_id = record['user_id']
        favorite.name= record['name']
        @favorites << favorite
    end
    return @favorites
    end


    def create(favorite)
      sql = 'SELECT * FROM favourites WHERE place_id = $1 AND user_id =$2;'
      sql_params = [
        favorite.place_id,
        favorite.user_id
      ]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
      if (result_set.any?)
      return false
       else 
        sql = 'INSERT INTO favourites (place_id, user_id, name)
        VALUES($1, $2, $3);'
        sql_params = [
        favorite.place_id,
        favorite.user_id,
        favorite.name
      ]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
       end
      
    end

end