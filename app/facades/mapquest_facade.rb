class MapquestFacade
  def initialize(location, service = MapQuestService.new)
    @location = location
    @service = service
    @coordinates = nil
  end

  def coordinates
    @coordinates ||= begin
      coordinates_json = @service.get_coordinates(@location)
      #^ this will happen only if the coordinates are not filled and blank/ be nil
      @coordinates = coordinates_json[:results].first[:locations].first[:latLng]
      # ^these are the coordiantes that it gets 
    end
  end
end