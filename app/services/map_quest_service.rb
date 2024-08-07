class MapQuestService 
  def conn
    conn = Faraday.new("https://www.mapquestapi.com") do |f|
      f.headers["Accept"] = "application/json"
    end
  end

  def get_url(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coordinates(location)
    get_url("/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=#{location}")
  end

  def get_travel_route(a, b)
    get_url("/directions/v2/route?key=#{Rails.application.credentials.mapquest[:key]}&from=#{a}&to=#{b}")
  end
end