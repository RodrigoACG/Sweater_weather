class BookFacade
  # attr_reader :location, :quantity

  # def initialize(location, quantity)
  #   # require 'pry'; binding.pry
  #   @location = location
  #   @quantity = quantity
  #   @service = BookService.new
  # end

  # def book_search 
  #   info = @service.book_search(@location, @quantity)
  #   info[:docs].map do |data|
  #     Book.new(data)
  #   end
  # end

  # def book_count
  #   books_info = @service.book_search(@location, @quantity)
  #   total_books = books_info[:numFound]
  # end

  attr_reader :total_books_found

  def initialize(location, quantity, service = BookService.new)
    @location = location
    @quantity = quantity.to_i
    @service = service
    load_books
  end

  def books
    @books ||= load_books
  end

  private

  def load_books
    books_json = @service.get_all_books(@location)
    @total_books_found = books_json[:numFound]
    books = books_json[:docs].take(@quantity)
    @books = books.map { |book_data| Book.new(book_data) }
  end
end