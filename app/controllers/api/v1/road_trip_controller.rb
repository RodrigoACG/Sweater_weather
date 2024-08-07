class Api::V1::RoadTripController < ApplicationController 
  before_action :find_user, only: [:create]

  def create
     a = params[:road_trip][:origin].gsub(/\s+/, "")
    b = params[:road_trip][:destination].gsub(/\s+/, "")
    travel_info = RoadTripFacade.new( a, b).travel_info
    weather = WeatherFacade.new(b, travel_info[:travel_time]).destination_weather
    render json: RoadTripSerializer.new(params[:road_trip][:origin], params[:road_trip][:destination], travel_info, weather).serialize
  end

  private

  def find_user
    @user = User.find_by(api_key: params[:road_trip][:api_key])
    # message = "Wrong Api Key or Missing One Please Check Again"
    render json: ErrorSerializer.new(ErrorMessage.new("Wrong Api Key or Missing One Please Check Again", 400))
      .serialize_json, status: :bad_request unless @user
  end
end