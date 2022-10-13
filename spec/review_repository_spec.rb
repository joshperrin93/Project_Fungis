require 'review_repository'

def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'vegan_restaurant_test' })
    connection.exec(seed_sql)
end

RSpec.describe ReviewRepository do
    before(:each) do
        reset_tables
    end

    describe "all" do
        it "returns an array of all reviews" do
            repo = ReviewRepository.new
            
            reviews = repo.all

            expect(reviews[0].place_id).to eq 'ChIJN1t_tDeuEmsRUsoyG83frY4'
            expect(reviews[0].comment).to eq "Very nice!"
            expect(reviews[0].user_id.to_i).to eq 1
            expect(reviews[0].user_name).to eq "Josh"
            expect(reviews[0].date_posted).to eq '2022-01-01'
            expect(reviews[0].rating.to_i).to eq 4
        end
    end

    describe "create" do
        it 'adds a new review' do
            new_review = Review.new
            review_repo = ReviewRepository.new
            new_review.place_id = 'ChIJF_kxdtYddkgR2ljex8ywClg'
            new_review.comment = 'Love this place'
            new_review.user_name = 'Ella'
            new_review.date_posted = '2022-01-01'
            new_review.rating = 1
            new_review.user_id = 2

            review_repo.create(new_review)

            expect(review_repo.all.size).to eq 5
            expect(review_repo.all.last.place_id).to eq 'ChIJF_kxdtYddkgR2ljex8ywClg'
            expect(review_repo.all.last.comment).to eq 'Love this place'
            expect(review_repo.all.last.user_name).to eq 'Ella'
            expect(review_repo.all.last.date_posted).to eq '2022-01-01'
            expect(review_repo.all.last.rating.to_i).to eq 1
            expect(review_repo.all.last.user_id.to_i).to eq 2
        end
    end

    describe "find_by_user_id" do
        xit "finds a place by user id" do
            repo = ReviewRepository.new
            review1 = repo.find_by_user_id(2)

            expect(review1.place_id.first).to eq 'ChIJN1t_tDeuEmsRUsoyG83frY4'
            expect(review1.user_name.first).to eq "Ella"

            review2 = repo.find_by_user_id(1)

            expect(review2.user_name.first).to eq "Josh"
            expect(review2.place_id.first).to eq 'ChIJN1t_tDeuEmsRUsoyG83frY4'
        end
    end
end