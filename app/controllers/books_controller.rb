class BooksController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :destroy, :pdf]

  def search
    if params[:search].present?
      @books = Book.order('lower(title)').search(params[:search])
    else
      @books = Book.order('lower(title)').paginate(page: params[:page], per_page: 5)
      # index:
    end
  end
  def index
    @books = Book.order('lower(title)').paginate(page: params[:page], per_page: 5)
  end

  def latest
    @books = Book.last(2)
  end

  def show
    @book = Book.find(params[:id])
    @articles = @book.articles
    @new_article = @book.articles.build
  end

  def new
    #session[:new_book] = true
    @book = Book.new
    #@book.authorships.build
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "Boken #{view_context.link_to(@book.title, @book)} är tillagd!"
      redirect_to new_book_path
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

  # http://stackoverflow.com/questions/17436264/how-to-use-rails-4-strong-parameters-with-has-many-through-association
  # http://stackoverflow.com/questions/21983131/rails-4-nested-attributes-and-has-many-through-associaton-in-a-form
  # http://stackoverflow.com/questions/18308714/nested-fields-and-strong-parameters

  private
  def book_params
    params.require(:book).permit(
      :title, :yearofpub, :about, :genre_id, :cover, :remove_cover, :pdf, :remove_pdf, :epub, :remove_epub,
      :cover_cache, :pdf_cache, :epub_cache,
      articles_attributes: [:id, :title, :writer, :year, :source, :about, :url, :_destroy],
      authorships_attributes: [:id, :_destroy, :book_id, :author_id,
                               author_attributes: [:id, :_destroy, :name, :about, :yearofbirth, :portrait, :remove_portrait, :portrait_cache]]
    )
  end

  # Before filters
  def admin_user
    redirect_to(books_url) unless logged_in? && current_user.admin?
  end
end
