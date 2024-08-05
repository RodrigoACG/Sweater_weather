class Api::V1::WeatherController < ApplicationController 
  def index 
    coordinates = MapquestFacade.new(params[:location]).coordinates.values.join(',')
    weather = WeatherFacade.new(coordinates).weather
    render json: WeatherSerializer.new(weather)
  end
  
end