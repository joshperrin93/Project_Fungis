require_relative 'user'
require_relative 'database_connection'

class UserRepository

  def all
    @users = []
    sql = 'SELECT * FROM users'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
        user = User.new
        user.id = record['id'].to_i
        user.email = record['email']
        user.password = record['password']
        user.name = record['name']

        @users << user
    end

    return @users
  end

  def create(new_user)
    sql = 'INSERT INTO users (email, password, name) VALUES($1, $2, $3);'
    sql_params = [
      new_user.email,
      new_user.password,
      new_user.name
    ]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_email(email)
    sql = "SELECT id, name, email, password FROM users WHERE email = $1;"
    result_set = DatabaseConnection.exec_params(sql, [email])

    # calls '#all method' to populate global @users array with test users.
    all
    return false unless @users.any? { |user| user.email == email }
    
    user = User.new
    user.id = result_set[0]["id"].to_i
    user.name = result_set[0]["name"]
    user.email = result_set[0]["email"]
    user.password = result_set[0]["password"]

    return user
  end

end