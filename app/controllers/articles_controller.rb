class ArticlesController < ApplicationController
  def index
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @articles = @author.articles
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @articles = @book.articles
    end
  end

  def show
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @article = @author.articles.build
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @article = @book.articles.build
    end
  end

  def new
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @article = @author.articles.build
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @article = @book.articles.build
    end
  end

  def create
    # If article belongs to book or author.
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @article = @author.articles.create(article_params)
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @article = @book.articles.create(article_params)
    end
    if @article.save
      flash[:success] = "Artikeln '#{@article.title}' är tillagd!"
    else
      # Saves error in session variable beacuse I can't render 'new'
      # See: https://railsforum.com/topic/403-im-stumped-displaying-error-messages/
      flash[:danger] = 'Artikel kunde inte sparas.'
      session[:errors] = @article.errors.full_messages
    end
    redirect_to :back
  end

  # Edit and Update method not working at the moment.
  def edit
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @article = @author.articles.find(params[:id])
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @article = @book.articles.find(params[:id])
    end
  end

  def update
    if params.key?(:author_id)
      @author = Author.find(params[:author_id])
      @article = @author.articles.find(params[:id])
    elsif params.key?(:book_id)
      @book = Book.find(params[:book_id])
      @article = @book.articles.find(params[:id])
    end
    if @article.update_attributes(article_params)
      flash[:success] = 'Artikeln är uppdaterad!'
      redirect_to :back
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = 'Artikel är raderad'
    redirect_to :back
  end

  private

  def article_params
    params.require(:article).permit(:title,
                                    :writer,
                                    :source,
                                    :year,
                                    :about,
                                    :url,
                                    :book_id,
                                    :author_id)
  end
end
