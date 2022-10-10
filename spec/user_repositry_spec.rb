require 'user_repository'

def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'vegan_restaurant_test' })
    connection.exec(seed_sql)
end

RSpec.describe UserRepository do
    before(:each) do
        reset_tables
    end

    describe "all" do
        it "returns an array of all users" do
            repo = UserRepository.new
            
            user = repo.all

            expect(user[0].name).to eq "Josh"
            expect(user[0].email).to eq "josh@makers.com"
            expect(user[0].password).to eq "password!123"
        end
    end

    describe "create" do
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

    describe "find_by_email" do
        it "finds a user by email address" do
            repo = UserRepository.new
            user1 = repo.find_by_email("ella@makers.com")

            expect(user1.name).to eq "Ella"
            expect(user1.password).to eq "password!123"

            user2 = repo.find_by_email("josh@makers.com")

            expect(user2.name).to eq "Josh"
            expect(user2.password).to eq "password!123"


        end
    end
end