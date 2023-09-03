class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def show
  end

  def library
    user_books = current_user.user_books
    @wish_list_books = books_from_status(user_books, 0)
    @reading_list_books = books_from_status(user_books, 1)
    @read_list_books = books_from_status(user_books, 2)
  end

  def search
    return unless params[:query].present?

    search_with_title
    search_with_author
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :score, :isbn, :cover_img_url)
  end

  def books_from_status(user_books, status)
    user_books.where(status: status).map(&:book)
  end

  def search_with_title
    @search_books_title = []
    GoogleBooks.search("intitle:#{params[:query]}", count: 10, country: "fr").each do |book|
      next unless valid_book?(book)

      add_book_in_db(book)
    end

    @search_books_title = Book.where('LOWER(title) LIKE ?', "%#{params[:query].downcase}%")
  end

  def search_with_author
    @search_books_author = []
    GoogleBooks.search("inauthor:#{params[:query]}", count: 10, country: "fr").each do |book|
      next unless valid_book?(book)

      add_book_in_db(book)
    end

    @search_books_author = Book.where('LOWER(author) LIKE ?', "%#{params[:query].downcase}%")
  end

  def valid_book?(book)
    return false if book.language != 'fr' && book.isbn.nil?
    return false unless Book.find_by(isbn: book.isbn.to_s).nil?
    return true if book.image_link.present?

    add_img_book(book)
    false
  end

  def add_book_in_db(book)
    new_book = build_book_from_google_book(book)
    new_book.save
  end

  def add_img_book(book)
    image = Openlibrary::Covers::Image.new(book.isbn.to_s)
    return unless image.found?

    new_book = build_book_from_google_book(book, image.url)
    new_book.save
  end

  def build_book_from_google_book(book, img_url = nil)
    Book.new(
      title: book.title.truncate(100),
      description: book.description,
      author: book.authors,
      cover_img_url: img_url || book.image_link,
      isbn: book.isbn,
      score: rand(10...100)
    )
  end
end
