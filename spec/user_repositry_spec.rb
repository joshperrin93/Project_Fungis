require 'user_repository'

def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'vegan_restaurant_test' })
    connection.exec(seed_sql)
end

RSpec.describe UserRepository do
    it 'adds a new user' do
        new_user = User.new
        user_repo = UserRepository.new
        new_user.email = 'neil@makers.com'
        new_user.password = 'password!1234'
        new_user.name = 'Neil'

        user_repo.create(new_user)

        expect(user_repo.all.size).to eq 5
        expect(user_repo.all.last.email).to eq 'neil@makers.com'
        expect(user_repo.all.last.password).to eq 'password!1234'
        expect(user_repo.all.last.name).to eq 'Neil'
    end
end