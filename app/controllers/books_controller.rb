require "csv"
class BooksController < ApplicationController
  before_action :authenticate_author!
 before_action :set_book, only: [:show, :edit, :update, :destroy]
before_action :authorize_owner!, only: [:edit, :update, :destroy]

def index
  @filterrific = initialize_filterrific(
    Book,
    params[:filterrific],
    persistence_id: false
  ) or return

  @books = @filterrific.find.includes(:author)

  respond_to do |format|
    format.html

    format.csv do
      send_data generate_csv(@books),
                filename: "books-#{Date.current}.csv"
    end
  end
end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_author.books.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
end

def update
  if @book.update(book_params)
    redirect_to @book, notice: "Book was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @book.destroy
  redirect_to books_path, notice: "Book was successfully deleted."
end

  private
def generate_csv(books)
  CSV.generate(headers: true) do |csv|
    csv << ["Book name", "Release date", "Author name"]

    books.each do |book|
      csv << [book.name, book.release_date, book.author.name]
    end
  end
end

def authorize_owner!
  unless @book.author == current_author
    redirect_to books_path, alert: "You are not allowed to do that."
  end
end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.expect(book: [:name, :release_date])
  end
end