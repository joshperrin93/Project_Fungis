require_relative 'review'
require_relative 'database_connection'

class ReviewRepository

    def all
      @reviews = []
      sql = 'SELECT * FROM reviews'
      result_set = DatabaseConnection.exec_params(sql, [])
      result_set.each do |record|
        review = Review.new
        review.id = record['id'].to_i
        review.place_id = record['place_id']
        review.comment = record['comment']
        review.rating = record['rating']
        review.date_posted = record['date_posted']
        review.user_id = record['user_id']
        review.user_name = record['user_name']

        @reviews << review
      end

      return @reviews
    end

    def create(new_review)
      sql = 'INSERT INTO reviews (place_id, comment, rating, date_posted, user_id, user_name)
                VALUES($1, $2, $3, $4, $5, $6);
            '
      sql_params = [
        new_review.place_id,
        new_review.comment,
        new_review.rating.to_i,
        new_review.date_posted,
        new_review.user_id.to_i,
        new_review.user_name,
      ]

      result_set = DatabaseConnection.exec_params(sql, sql_params)
    end

    def find_by_user_id(user_id)
      sql = "SELECT place_id FROM reviews WHERE user_id = $1;"
      result_set = DatabaseConnection.exec_params(sql, [user_id])
  
      # calls '#all method' to populate global @users array with test users.
      all
      return false unless @reviews.any? { |review| review.place_id == place_id }
    end

end