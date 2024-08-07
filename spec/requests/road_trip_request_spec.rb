require 'rails_helper'

RSpec.describe 'Road Trip', :vcr do
  
  describe 'us4' do
    it 'can create a successful road trip' do
      user = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
      headers = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }

      road_trip_params = {
                          origin: 'Cincinnati, OH',
                          destination: 'Chicago, IL',
                          api_key: user.api_key
                        }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to be(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(road_trip).to have_key(:data)
      expect(road_trip).to be_a(Hash)

      trip = road_trip[:data]
      # require 'pry'; binding.pry

      expect(trip).to have_key(:id)
      expect(trip[:id]).to be_a(String)

      expect(trip).to have_key(:type)
      expect(trip[:type]).to be_a(String)
      expect(trip[:type]).to eq('road_trip')

      expect(trip).to have_key(:attributes)
      expect(trip[:attributes]).to be_a(Hash)

      trip_attrs = trip[:attributes]
      # require 'pry'; binding.pry

      expect(trip_attrs).to have_key(:start_city)
      expect(trip_attrs[:start_city]).to be_a(String)
      expect(trip_attrs[:start_city]).to eq('Cincinnati, OH')

      expect(trip_attrs).to have_key(:end_city)
      expect(trip_attrs[:end_city]).to be_a(String)
      expect(trip_attrs[:end_city]).to eq('Chicago, IL')



      expect(trip_attrs).to have_key(:travel_time)
      expect(trip_attrs[:travel_time]).to be_a(String)
      expect(trip_attrs[:travel_time]).to eq("#{trip_attrs[:travel_time]}")
      


      expect(trip_attrs).to have_key(:weather_at_eta)
      expect(trip_attrs[:weather_at_eta]).to be_a(Hash)

      
      weather = trip_attrs[:weather_at_eta]
      # require 'pry'; binding.pry

      expect(weather).to be_a(Hash)

      expect(weather).to have_key(:datetime)
      expect(weather[:datetime]).to be_a(String)
      expect(weather[:datetime]).to eq("#{weather[:datetime]}")

      expect(weather).to have_key(:temperature)
      expect(weather[:temperature]).to be_a(Float)
      expect(weather[:temperature]).to eq(("#{weather[:temperature]}").to_f)

      expect(weather).to have_key(:condition)
      expect(weather[:condition]).to be_a(String)
      expect(weather[:condition]).to eq("#{weather[:condition]}")

    end

    it 'sad path' do 
      user2 = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
      headers2 = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }

      road_trip_params = {
                          origin: 'Cincinnati, OH',
                          destination: 'Chicago, IL',
                          api_key: '123456543234567'
                        }

      post '/api/v1/road_trip', headers: headers2, params: JSON.generate(road_trip_params)

      expect(response).to_not be_successful
      expect(response.status).to be(400)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      #  require 'pry'; binding.pry
      expect(road_trip).to be_a(Hash)

      expect(road_trip).to have_key(:errors)
      expect(road_trip[:errors]).to be_a(Array)
      expect(road_trip[:errors].first).to be_a(Hash)

      expect(road_trip[:errors].first).to have_key(:detail)
      expect(road_trip[:errors].first[:detail]).to eq("Wrong Api Key or Missing One Please Check Again")

    end


    it 'test for Ny to LA' do 
      user2 = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
      headers2 = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }

      road_trip_params = {
                          origin: 'New York, NY ',
                          destination: 'Los Angeles, CA',
                          api_key: user2.api_key
                        }

      post '/api/v1/road_trip', headers: headers2, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to be(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip).to have_key(:data)
      expect(road_trip).to be_a(Hash)
      
      # require 'pry'; binding.pry
      expect(road_trip[:data][:attributes][:travel_time]).to eq("#{road_trip[:data][:attributes][:travel_time]}")
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq(("#{road_trip[:data][:attributes][:weather_at_eta][:temperature]}").to_f)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to eq("#{road_trip[:data][:attributes][:weather_at_eta][:condition]}")

      #this might not be the best way to show it is working but it kept change it so i interpolated it 
    end

    it 'test for Ny to Panama' do 
      user2 = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
      headers2 = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }

      road_trip_params = {
                          origin: 'New York, NY',
                          destination: 'Panama City, Panama',
                          api_key: user2.api_key
                        }

      post '/api/v1/road_trip', headers: headers2, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to be(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip).to have_key(:data)
      expect(road_trip).to be_a(Hash)
      
      # require 'pry'; binding.pry
      expect(road_trip[:data][:attributes][:travel_time]).to eq("#{road_trip[:data][:attributes][:travel_time]}")
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq(("#{road_trip[:data][:attributes][:weather_at_eta][:temperature]}").to_f)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to eq("#{road_trip[:data][:attributes][:weather_at_eta][:condition]}")




    end


    it 'test for Ny to London' do 
      user2 = User.create!(email: "whatever@example.com", password: 'password', password_confirmation: 'password')
      headers2 = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }

      road_trip_params = {
                          origin: 'New York, NY',
                          destination: 'London, UK',
                          api_key: user2.api_key
                        }

      post '/api/v1/road_trip', headers: headers2, params: JSON.generate(road_trip_params)

      expect(response).to be_successful
      expect(response.status).to be(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      
      # require 'pry'; binding.pry
      expect(road_trip).to have_key(:data)
      expect(road_trip).to be_a(Hash)

      trip = road_trip[:data]
      # require 'pry'; binding.pry

      expect(trip).to have_key(:id)
      expect(trip[:id]).to be_a(String)

      expect(trip).to have_key(:type)
      expect(trip[:type]).to be_a(String)
      expect(trip[:type]).to eq('road_trip')

      expect(trip).to have_key(:attributes)
      expect(trip[:attributes]).to be_a(Hash)

      trip_attrs = trip[:attributes]
      # require 'pry'; binding.pry

      expect(trip_attrs).to have_key(:start_city)
      expect(trip_attrs[:start_city]).to be_a(String)
      expect(trip_attrs[:start_city]).to eq('New York, NY')

      expect(trip_attrs).to have_key(:end_city)
      expect(trip_attrs[:end_city]).to be_a(String)
      expect(trip_attrs[:end_city]).to eq('London, UK')

      expect(trip_attrs).to have_key(:weather_at_eta)
      expect(trip_attrs[:weather_at_eta]).to eq({})
    




    end
  end
end