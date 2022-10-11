require "spec_helper"
require "rack/test"
require_relative '../../app'

# def reset_tables
#     seed_sql = File.read('spec/seeds/bookings_seeds.sql')
#     connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
#     connection.exec(seed_sql)
# end

describe Application do

    include Rack::Test::Methods

    let(:app) { Application.new }

    # before(:each) do 
    #     reset_tables 
    # end
    
    context "GET /index" do
        it 'returns 200 OK and the search page' do
        response = get('/index')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1> Fungis </h1>')
        end
    end

    context "POST /index" do
        it "doesn't log a user in if they input incorrect credentials" do
            response = post("/index", email: "ella@makers.com", password: "assword!123")
            expect(response.status).to eq 200
            expect(response.body).to include('<h1>Incorrect credentials</h1>')
        end
        it "does log a user in if they input correct credentials" do
            response = post("/index", email: "ella@makers.com", password: "password!123")
            expect(response.status).to eq 302
            expect(response.body).to include('')
        end
    end

    context 'GET /signup_success' do
        xit "lets a user know that they have signed up successfully" do
            response = get('/signup_success')
            expect(response.status).to eq 200
            expect(response.body).to include('<h1>Welcome to Fungis <%=@new_user.name%>!</h1>')
        end
    end

    context 'post /results' do
        it "shows the user the results of their search in a list" do
            response = post("/results", location: "london")
            expect(response.status).to eq 200
            expect(response.body).to include('<h1>Search results</h1>')
        end
    end

    context 'GET /index/:place_id' do
        it "returns more detailed info about a specific place" do
            response = get("/index/ChIJi5rjorccdkgRhHRpRo5pQDE")
            expect(response.status).to eq 200
            expect(response.body).to include("More info on The Vurger Co Shoreditch")
        end
    end

    context 'GET /signup' do
        it "returns the signup page and form" do
            response = get("/signup")
            expect(response.status).to eq 200
            expect(response.body).to include('<form method = "post" action = "/signup_success"> ')
        end
    end

    context "GET /login" do
        it "returns the login page" do
            response = get("/login")
            expect(response.status).to eq 200
            expect(response.body).to include('<h1>Login page</h1>')
        end
    end

    context "POST /signup_success" do
        xit "returns the signup success page with the login form" do
            response = post("/signup_success", email: "ella@makers.com", password: "password!123")
            expect(response.status).to eq 200
            expect(response.body).to include('<input type="password"  name="password" placeholder="Password">')
        end
    end

    context "GET /favorite_restaurants" do
        it "returns the favorite_restuarants page" do
            response = get("/favorite_restaurants")
            expect(response.status).to eq 200
            expect(response.body).to include("")
        end
    end

    context "POST /favorite_restaurants" do
        xit "adds saves a restaurant" do
            response = post("", favorite = "ChIJaxWqk7UcdkgRjr3dwrPTj8I")
            expect(response.status).to eq 200
        end
    end

    context "POST /index/:place_id" do
        xit "allows a logged in user to add a comment and rate a recipe" do
            response = post("/index/#{'ChIJaxWqk7UcdkgRjr3dwrPTj8I'}", rating: 3, review: "Lovely")
            expect(response.status).to eq 200
            expect(response.body).to include "Lovely"
        end
    end


end