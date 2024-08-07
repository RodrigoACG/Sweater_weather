class RoadTripSerializer 

  def initialize(a, b, travel_info, weather)
    @a = a
    @b = b
    @travel_info = travel_info
    @weather = weather
  end

  def serialize
    {
      data: {
        id: "null",
        type: "road_trip",
        attributes: {
           start_city: @a,
            end_city: @b,
          travel_time: @travel_info[:travel_time],
          weather_at_eta: weather_data
        }
      }
    }
  end

  private

  def weather_data
    if @weather[:datetime].present?
      {
        datetime: @weather[:datetime],
        temperature: @weather[:temperature],
        condition: @weather[:condition]
      }
    else
      {
        
      }
    end
  end
end