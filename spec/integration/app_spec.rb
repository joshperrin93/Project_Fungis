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
        it 'returns the search page' do
        response = get('/index')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1> Fungis </h1>')
        end
    end
end