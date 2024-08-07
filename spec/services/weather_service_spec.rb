require 'rails_helper'

RSpec.describe 'Weather Service', :vcr do
 

  describe '#get_weather' do
    it 'gets the weather of that area' do
      weather = WeatherService.new.get_weather("39.74001, -104.99202")
      
      # require 'pry'; binding.pry
      expect(weather).to be_a(Hash)
      expect(weather[:location]).to be_a(Hash)
      
      expect(weather).to have_key(:current)
      expect(weather[:current]).to be_a(Hash)
      expect(weather[:current]).to have_key(:temp_f)
      expect(weather[:current]).to have_key(:last_updated)
      expect(weather[:current]).to have_key(:condition)
      expect(weather[:current][:condition]).to have_key(:text)
      expect(weather[:current][:condition][:text]).to eq("#{weather[:current][:condition][:text]}")
      expect(weather[:current]).to have_key(:humidity)
      expect(weather[:current]).to have_key(:wind_mph)



      expect(weather).to have_key(:forecast)
      expect(weather[:forecast]).to be_a(Hash)
      expect(weather[:forecast]).to have_key(:forecastday)
      expect(weather[:forecast][:forecastday]).to be_a(Array)

      weather_attrs = weather[:forecast][:forecastday].first
      expect(weather_attrs).to be_a(Hash)

      expect(weather_attrs[:date]).to eq("2024-08-07")

      expect(weather_attrs[:day]).to be_a(Hash)

      day_weater = weather_attrs[:day]

      expect(day_weater).to be_a(Hash)
      expect(day_weater).to have_key(:maxtemp_f)
      expect(day_weater[:maxtemp_f]).to be_a(Float)
      expect(day_weater[:maxtemp_f]).to eq(("#{day_weater[:maxtemp_f]}").to_f)
      
      expect(day_weater).to have_key(:avgtemp_f)
      expect(day_weater[:avgtemp_f]).to be_a(Float)
      expect(day_weater[:avgtemp_f]).to eq(("#{day_weater[:avgtemp_f]}").to_f)

      expect(day_weater).to have_key(:maxwind_mph)
      expect(day_weater[:maxwind_mph]).to be_a(Float)
      expect(day_weater[:maxwind_mph]).to eq(("#{day_weater[:maxwind_mph]}").to_f)

      expect(day_weater).to have_key(:daily_chance_of_rain)
      expect(day_weater[:daily_chance_of_rain]).to be_a(Integer)
      expect(day_weater[:daily_chance_of_rain]).to eq(("#{day_weater[:daily_chance_of_rain]}").to_f)

      expect(day_weater).to have_key(:condition)
      expect(day_weater[:condition]).to be_a(Hash)

      expect(day_weater[:condition]).to have_key(:text)
      expect(day_weater[:condition][:text]).to eq("#{day_weater[:condition][:text]}")

      hourly = weather[:forecast][:forecastday].first[:hour].first
        # require 'pry'; binding.pry
      expect(hourly).to be_a(Hash)

      expect(hourly).to have_key(:temp_f)
      expect(hourly[:temp_f]).to be_a(Float)

      expect(hourly).to have_key(:condition)
      expect(hourly[:condition]).to be_a(Hash)
      expect(hourly[:condition]).to have_key(:text)

      expect(hourly[:condition][:text]).to be_a(String)
      expect(hourly[:condition][:text]).to eq("#{hourly[:condition][:text]}")
      
      expect(hourly).to have_key(:wind_mph)
      expect(hourly[:wind_mph]).to be_a(Float)
      
      expect(hourly).to have_key(:humidity)
      expect(hourly[:humidity]).to be_a(Integer)
      
      expect(hourly).to have_key(:feelslike_f)
      expect(hourly[:feelslike_f]).to be_a(Float)
      
    end
  end
end