class Api::V1::BookSearchController < ApplicationController
  # def index
  #   destination = params[:location]
  #   quantity = params[:quantity]

  #   weather = WeatherFacade.new(destination).weather

  #   book_facade = BookFacade.new(destination, quantity)

  #   total_books = book_facade.book_count

  #   books = book_facade.book_search

  #   render json: BooksSerializer.new(
  #     destination, 
  #     weather, 
  #     total_books, 
  #     books).serialize
  # end


  # def index
  #   destination = params[:location]
  #   quantity = params[:quantity]

  #   weather = WeatherFacade.new(destination).weather.todays_weather
  #   book_facade = BooksFacade.new(destination, quantity)

  #   total_books = book_facade.total_books_found
  #   book_search = book_facade.books

  #   render json: BooksSerializer.new(
  #     destination, 
  #     weather, 
  #     total_books, 
  #     book_search).serialize
  # end

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