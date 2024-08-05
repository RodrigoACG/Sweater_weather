class WeatherFacade
  def initialize(coordinates, travel_time = nil, service = WeatherService.new)
    @coordinates = coordinates
    @travel_time = travel_time
    @service = service
    @weather = nil
  end

  def weather
    @weather ||= begin
      weather_json = @service.get_weather(@coordinates)
      @weather = Weather.new(weather_json)
    end
  end
end