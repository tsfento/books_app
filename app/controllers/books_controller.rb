class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all
    render json: BooksBlueprint.render(@books, view: :normal)
  end

  # GET /books/:id
  def show
    render json: BooksBlueprint.render(@book, view: :normal)
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      render json: BooksBlueprint.render(@book, view: :normal), status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      render json: BooksBlueprint.render(@book, view: :normal)
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    if @book.destroy
      render json: nil, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :read)
  end
end
