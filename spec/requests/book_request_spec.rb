require 'rails_helper'
 
RSpec.describe 'Book ', :vcr do

  describe '#final us' do
    it 'get destination, the forcast in that city, the total number of books found and a collection of books about the destination ' do
      get '/api/v1/book-search?location=denver,co&quantity=5', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }


      expect(response).to be_successful
      # require 'pry'; binding.pry
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(data).to have_key(:data)
      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes][:destination]).to be_a(String)
      expect(data[:data][:attributes][:forecast]).to be_a(Hash)
      expect(data[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(data[:data][:attributes][:forecast][:temperature]).to be_a(Float)

    end

    
  end
end