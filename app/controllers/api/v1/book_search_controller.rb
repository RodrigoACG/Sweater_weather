class Api::V1::BookSearchController < ApplicationController
  def index
    destination = params[:location]
    quantity = params[:quantity]

    weather = WeatherFacade.new(destination).weather
    forecast = weather.todays_weather
    book_facade = BookFacade.new(destination, quantity)

    total_books = book_facade.total_books_found
    books = book_facade.books

    render json: BookSerializer.new(
      destination, 
      forecast, 
      total_books, 
      books
    ).serialize
  end
end