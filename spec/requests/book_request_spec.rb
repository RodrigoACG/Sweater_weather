require 'rails_helper'
 
RSpec.describe 'Book ', :vcr do

  describe '#final us' do
    it 'get destination, the forcast in that city, the total number of books found and a collection of books about the destination ' do
      get '/api/v1/book-search?location=denver,co&quantity=5', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }


      expect(response).to be_successful
      # require 'pry'; binding.pry
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry÷÷
      expect(data).to have_key(:data)

      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes]).to include(:destination)
      expect(data[:data][:attributes]).to include(:forecast)
      expect(data[:data][:attributes]).to include(:total_books_found)
      expect(data[:data][:attributes]).to include(:books)


      expect(data[:data][:attributes][:destination]).to be_a(String)
      expect(data[:data][:attributes][:destination]).to eq('denver,co')

      expect(data[:data][:attributes][:forecast]).to be_a(Hash)
      expect(data[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(data[:data][:attributes][:forecast][:summary]).to eq('Sunny')

      expect(data[:data][:attributes][:forecast][:temperature]).to be_a(Float)
      expect(data[:data][:attributes][:forecast][:temperature]).to eq(92.5)

      expect(data[:data][:attributes][:total_books_found]).to be_a(Integer)
      expect(data[:data][:attributes][:total_books_found]).to eq(756)

      expect(data[:data][:attributes][:books]).to be_a(Array)

      expect(data[:data][:attributes][:books].first).to include(:title)
      expect(data[:data][:attributes][:books].first[:title]).to eq('Denver, Co')
      expect(data[:data][:attributes][:books].first[:title]).to be_a(String)

      expect(data[:data][:attributes][:books].first).to include(:isbn)
      expect(data[:data][:attributes][:books].first[:isbn]).to be_a(Array)
      expect(data[:data][:attributes][:books].first[:isbn]).to eq(["9780762507849", "0762507845"])
      expect(data[:data][:attributes][:books].first[:isbn].first).to eq("9780762507849")
      expect(data[:data][:attributes][:books].first[:isbn].last).to eq("0762507845")


      expect(data[:data][:attributes][:books].first).to include(:publisher)
      expect(data[:data][:attributes][:books].first[:publisher]).to be_a(Array)
      expect(data[:data][:attributes][:books].first[:publisher]).to eq(["Universal Map Enterprises"])
      expect(data[:data][:attributes][:books].first[:publisher].first).to eq("Universal Map Enterprises")

    end

    
  end
end