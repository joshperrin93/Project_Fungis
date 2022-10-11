require 'favorites_repository'

def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'vegan_restaurant_test' })
    connection.exec(seed_sql)
end

RSpec.describe Favorites_Repository do
    before(:each) do
        reset_tables
    end

    describe "all" do
        it "returns an array of favourite places" do
            repo = Favorites_Repository.new
            
            favorites = repo.all

            expect(favorites[0].place_id).to eq "ChIJk2NryLQpQg0R6SZUS4VF-84"
            expect(favorites[0].user_id).to eq "1"
            expect(favorites[0].name).to eq "THUNDER Vegan Malasaña"

        end
    end

    describe "create" do
        it 'adds a new favourite place to your favourites page' do
            new_favourite = Favorites.new
            favourite_repo = Favorites_Repository.new
            new_favourite.place_id = "ChIJpUYnul5OqEcRamNwyfDphRQ"
            new_favourite.user_id = 1
            new_favourite.name = "FACTORY GIRL"

            favourite_repo.create(new_favourite)

            expect(favourite_repo.all.size.to_i).to eq 3
            expect(favourite_repo.all.last.place_id).to eq "ChIJpUYnul5OqEcRamNwyfDphRQ"
            expect(favourite_repo.all.last.user_id.to_i).to eq 1
            expect(favourite_repo.all.last.name).to eq "FACTORY GIRL"
        end
    end

    describe "user_favorite(user_session_id)" do
        xit "finds a users favourites by their user_id" do
        end
    end


end