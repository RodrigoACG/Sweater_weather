require 'time'

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

  def destination_weather
    @destination_weather ||= begin
     destination_weather_data = @service.get_weather(@coordinates)
      if @travel_time == "impossible"
        @destination_weather = {}
      else
        arrival_time = calc_time
        weather_time = destination_weather_data[:forecast][:forecastday].find do |day|
          day[:date] == arrival_time[:date]
        end&.dig(:hour)&.find { |hour| hour[:time] == arrival_time[:time] }

        if weather_time
          @destination_weather = {
            datetime: weather_time[:time],
            temperature: weather_time[:temp_f],
            condition: weather_time[:condition][:text]
          }
        end
    
        @destination_weather
      end
    end
  end

  private
  def calc_time
    current_time = Time.now
    travel_time = @travel_time.split(':').map(&:to_i)
    travel__seconds = travel_time[0] * 3600 + travel_time[1] * 60 + travel_time[2]

    arrival_time = current_time + travel__seconds
    { date: arrival_time.strftime("%Y-%m-%d"),
      time: Time.at((arrival_time.to_i / 3600) * 3600).strftime("%Y-%m-%d %H:%M") }
  end
end