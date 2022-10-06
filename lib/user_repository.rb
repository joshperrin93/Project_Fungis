require_relative 'user'
require_relative 'database_connection'

class UserRepository

    def all
        users = []
        sql = 'SELECT * FROM users'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
            user = User.new
            user.email = record['email']
            user.password = record['password']
            user.name = record['name']

            users << user
        end
    return users
    end

    def create(new_user)
      sql = 'INSERT INTO users (email, password, name)
                VALUES($1, $2, $3);
            '
      sql_params = [
        new_user.email,
        new_user.password,
        new_user.name
      ]
      result_set = DatabaseConnection.exec_params(sql, sql_params)
    end

end