require 'rails_helper'

RSpec.describe 'weather_poro' do
  before(:each) do
    @weather_data = {
      current: {
        last_updated: "2024-08-07 03:00",
        temperature: 74.6,
        feelslike_f: 76.6,
        humidity: 43,
        uvi: 1.0,
        visibility: 6.0,
        condition: "Clear",
        icon: "//cdn.weatherapi.com/weather/64x64/night/113.png"
      },
      forecast: {
        forecastday:[{
          date: "2024-08-07",
          day: {
            avgtemp_f: 81.5,
            astro: {
              sunrise: '06:05 AM',
              sunset: '08:05 PM',
              moon_phase: "Waxing Crescent"
            },
            condition: {
              text:"Patchy rain nearby",
              icon: "//cdn.weatherapi.com/weather/64x64/day/176.png"
            },
          hour:[{
            time: "2024-08-07 00:00",
            temp_f: 77.2,
            condition: {
              text: "Clear",
              icon:"//cdn.weatherapi.com/weather/64x64/night/113.png"
            }
          }]
          }
        }]
      }
    }

    @weather = Weather.new(@weather_data)
    
  end

  describe '#initialize' do
    it 'current,daily,hourly' do
      expect(@weather.current_data[:feelslike_f]).to eq(76.6)
      expect(@weather.daily_data[:sunrise]).to eq('06:05 AM')
      expect(@weather.hourly_data[:time]).to eq("2024-08-07 00:00")
    end

    it 'current' do 
      expect(@weather.current_data[:temperature]).to eq(74.6)
      expect(@weather.current_data[:humidity]).to eq(43)
      expect(@weather.current_data[:visibility]).to eq(6.0)
    end

    it 'daily' do 
      expect(@weather.daily_data[:sunset]).to eq('08:05 PM')
      expect(@weather.daily_data[:moon_phase]).to eq("Waxing Crescent")
      expect(@weather.daily_data[:condition][:text]).to eq("Patchy rain nearby")
    end 

    it 'hourly' do 
      expect(@weather.hourly_data[:temp_f]).to eq(77.2)
      expect(@weather.hourly_data[:condition][:text]).to eq("Clear")
    end

    #Tests might not be the best it is 5 in the morning. I did try my best on this project  I think i am now done 
  end
end