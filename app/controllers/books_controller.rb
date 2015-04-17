class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

      # @book = @genre.books.build(title: "Röda rummet", yearofpub: 1879,
      #             about: "En roman av Strindberg.")

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Boken #{@book.title} är tillagd!"
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  # def update
  #   @book = Book.find(params[:id])
  #   if @book.update_attributes(book_params)
  #     flash[:success] = "Boken är uppdaterad!"
  #     redirect_to @book
  #   else
  #     render 'edit'
  #   end
  # end

  def delete
  end

  private
    def book_params
      params.require(:book).permit(:title, :yearofpub, :about, :genre_id, :cover)
    end

    # def genre_params
    #   params.require(:genre).permit(:genre)
    # end

    # def selected_genre
    #   Genre.find_by(id: book[:genre_id])
    # end
end
