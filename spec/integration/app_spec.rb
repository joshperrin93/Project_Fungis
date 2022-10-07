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




end