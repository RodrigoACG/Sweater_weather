class RoadTripFacade

  def initialize(a, b, service = MapQuestService.new)
    @a = a
    @b = b
    @service = service
    @travel_info = nil
  end

  def travel_info
    @travel_info ||= begin
      json = @service.get_travel_route(@a, @b)
      if json[:route][:formattedTime]  
        @travel_info = {
           start_city: @a,
           end_city: @b,
          travel_time: json[:route][:formattedTime]
        }
      else
        @travel_info = {
           start_city: @a,
           end_city: @b,
          travel_time: "impossible"
        }
      end
    end
  end
end
