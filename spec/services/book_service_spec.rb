require 'rails_helper'

RSpec.describe 'Book Service', :vcr do
  

  describe '#get_all_books' do
    it 'connects correctly' do
      book_service = BookService.new
      books = book_service.get_all_books('Long Beach, NY')
      # require 'pry'; binding.pry

      expect(books).to be_a(Hash)
      expect(books).to be_key(:numFound)

      book= books[:docs]
      # require 'pry'; binding.pry
      expect(book.first).to have_key(:title)
      expect(book.first).to have_key(:publisher)
      expect(book.first).to have_key(:author_name)
      expect(book.first).to have_key(:language)
      # expect(book.first).to have_key(:isbn)

    end
  end
end