class BooksController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def latest
    @books = Book.last(10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Boken '#{@book.title}' är tillagd!"
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Boken är uppdaterad!"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Bok raderad!"
    redirect_to books_url
  end

  private
    def book_params
      params.require(:book).permit(:title, :yearofpub, :about, :genre_id, :cover, :author, :pdf, :epub)
    end

    # Before filters
    def admin_user
      redirect_to(books_url) unless logged_in? && current_user.admin?
    end
end
