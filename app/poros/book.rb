class Book 
  attr_reader :data

  def initialize(book_data)
    @data = book_info(book_data)
  end

  def book_info(data)
    {
      isbn: data[:isbn],
      title: data[:title],
      publisher: data[:publisher]
    }
  end

  
end