class BooksController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
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
      flash[:success] = "Boken #{@book.title} är tillagd!"
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
    # Försvinner cover?
    redirect_to books_url
  end


      # Metod som laddar ner omslag. Ska senare bli pdf/epub. Lägg till gem mime-types.
      # http://stackoverflow.com/questions/15326776/file-download-from-link-of-carrierwave-document-attachment
      # Fungerar inte på heroku. Måste få url till aws s3 bucket.
    # uploader = PictureUploader.new.store_dir

    def download_file
        @book = Book.find(params[:id])
        send_file @book.cover.path
    end


    # def download_file
    #     @book = Book.find(params[:id])
    #     send_file(@book.cover.path,
    #         :disposition => 'attachment',
    #         :url_based_filename => false)
    # end

  private
    def book_params
      params.require(:book).permit(:title, :yearofpub, :about, :genre_id, :cover, :author)
    end

    # Before filters
    def admin_user
      redirect_to(books_url) unless logged_in? && current_user.admin?
    end
end
