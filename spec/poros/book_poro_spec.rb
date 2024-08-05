require 'rails_helper'

RSpec.describe 'book poro', :vcr do
  

  describe '#shows attributes' do
    it 'displays the attributes a book has' do
      data = 
      {
        isbn: "9780762507849",
        title: 'Denver, Co',
        publisher: "Universal Map Enterprises"
      }

      book = Book.new(data)

      expect(book.data[:isbn]).to eq( "9780762507849")
      expect(book.data[:title]).to eq('Denver, Co')
      expect(book.data[:publisher]).to eq("Universal Map Enterprises")

    end
  end
end