require 'rails_helper'

RSpec.describe 'Weather tests', :vcr do

  describe '#us 1' do
    it 'retrieves weather for a city' do

      get "/api/v1/weather?location=cincinatti,oh", headers:  { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      expect(response).to be_successful
      
      expect(response.status).to eq(200)
      
      data = JSON.parse(response.body, symbolize_names:true)[:data]
      
      expect(data).to be_a(Hash)
      expect(data[:id]).to be(nil)

      expect(data[:type]).to eq("weather")
      
      expect(data[:attributes]).to have_key(:current_weather)
      expect(data[:attributes]).to have_key(:daily_weather)
      expect(data[:attributes]).to have_key(:hourly_weather)
  
      attributes = data[:attributes]
      expect(attributes).to be_a(Hash)
  
      data_current = attributes[:current_weather]

      # Current  
  
      expect(data_current).to be_a(Hash)
      expect(data_current[:last_updated]).to be_a(String)
      expect(data_current[:temperature]).to be_a(Float)
      expect(data_current[:feels_like]).to be_a(Float)
      expect(data_current[:humidity]).to be_a(Integer)
      expect(data_current[:uvi]).to be_a(Float)
      expect(data_current[:visibility]).to be_a(Float)
      expect(data_current[:condition]).to be_a(String)
      expect(data_current[:icon]).to be_a(String)
      expect(data_current[:wind_dir]).to be nil
      expect(data_current[:cloud]).to be nil
      expect(data_current[:pressure_mb]).to be nil
      expect(data_current[:cloud]).to be nil
      expect(data_current[:gust_kph]).to be nil

      #daily 
  
      daily = attributes[:daily_weather]
  
      expect(daily).to be_a(Array)
  
      daily.each do |data|
  
        expect(data[:date]).to be_a(String)
        expect(data[:sunrise]).to be_a(String)
        expect(data[:sunset]).to be_a(String)
        expect(data[:max_temp]).to be_a(Float)
        expect(data[:min_temp]).to be_a(Float)
        expect(data[:condition]).to be_a(String)
        expect(data[:icon]).to be_a(String)
        expect(data[:will_it_rain]).to be nil
        expect(data[:will_it_snow]).to be nil
      end
  
      #hourly data
      hourly = attributes[:hourly_weather]
  
      expect(hourly).to be_a(Array)
  
      hourly.each do |data|
        expect(data[:time]).to be_a(String)
        expect(data[:temperature]).to be_a(Float)
        expect(data[:condition]).to be_a(String)
        expect(data[:icon]).to be_a(String)
        expect(data[:feelslike_f]).to be nil
        expect(data[:gust_kph]).to be nil
        expect(data[:dewpoint_c]).to be nil
      end
    end
  end
end