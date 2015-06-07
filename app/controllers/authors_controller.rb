class AuthorsController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]

  def search
    if params[:search].present?
      @authors = Author.search(params[:search])
    else
      @authors = Author.order('lower(name)').paginate(page: params[:page], per_page: 10)
    end
  end

  def index
    @authors = Author.order('lower(name)').paginate(page: params[:page], per_page: 10)
  end

  def latest
    @authors = Author.last(2)
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
    @articles = @author.articles
    @new_article = @author.articles.build
  end

  def new
    session[:return_to] ||= request.referer
    @author = Author.new
    # @author.articles.build
  end

  def create
    @author = Author.new(author_params)
    if @author.save
    	# To be able to add several authors user is redirected to same form, but
    	# link to the new authors page is displayed in success message.
      flash[:success] = "Författaren #{view_context.link_to(@author.name, @author)} är tillagd!"
      redirect_to session.delete(:return_to) || usernew_author_path
    else
      render 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      flash[:success] = "Författaren är uppdaterad!"
      redirect_to @author
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Författare raderad"
    redirect_to authors_url
  end

  def add_articles(id)
    @author = Author.find(id)
    @author.article.build
  end

  private
  def author_params
    params.require(:author).permit(:name, :about, :yearofbirth, :portrait, :portrait_cache, :remove_portrait,
                                   articles_attributes: [:id, :title, :writer, :year, :source, :about, :url, :_destroy])
  end

  # Before filters
  def admin_user
    redirect_to(authors_url) unless logged_in? && current_user.admin?
  end
end
