require "rails_helper"

RSpec.describe 'WeatherFacade', :vcr do
  describe '#initialize' do
    it 'instance' do
      facade = WeatherFacade.new("39.74001, -104.99202")

      expect(facade).to be_an_instance_of(WeatherFacade)
    end
  end

  describe '#weather' do
    it 'shows the weather' do
      facade = WeatherFacade.new("39.74001, -104.99202")

      weather = facade.weather

      expect(weather).to be_an_instance_of(Weather)
      expect(weather.current_weather).to be_a(Hash)
      expect(weather.daily_weather).to be_an(Array)
      expect(weather.hourly_weather).to be_an(Array)
    end
  end 
end