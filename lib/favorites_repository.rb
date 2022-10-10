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

            @favorites << favorite
        end
    return @favorites
    end


    def create(favorite)
      sql = 'INSERT INTO favourites (place_id, user_id)
                VALUES($1, $2);
            '
      sql_params = [
        favorite.user_id,
        favorite.place_id
      ]

  
      result_set = DatabaseConnection.exec_params(sql, sql_params)
    end

end