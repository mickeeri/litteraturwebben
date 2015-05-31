class ArticlesController < ApplicationController

	# Soruce: http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/

	# def new
	# 	@article = Article.new
	# end

	# def destroy
	# 	@book = Book.find(params[:id])
	# 	@article = @book.articles.find(params[:id])
	# 	@article.destroy
	# 	flash[:success] = "Artikel raderad"
	# 	redirect_to @book
	# end

	def index
		if params.has_key?(:author_id)
			@author = Author.find(params[:author_id])
			@articles = @author.articles
		elsif params.has_key?(:book_id)
			@book = Book.find(params[:book_id])
			@articles = @book.articles
		end
	end

	def show
		if params.has_key?(:author_id)
			@author = Author.find(params[:author_id])
			@article = @author.articles.build
		elsif params.has_key?(:book_id)
			@book = Book.find(params[:book_id])
			@article = @book.articles.build
		end
	end

	def new
		if params.has_key?(:author_id)
			@author = Author.find(params[:author_id])
			@article = @author.articles.build
		elsif params.has_key?(:book_id)
			@book = Book.find(params[:book_id])
			@article = @book.articles.build
		end





		# @author = Author.find(params[:author_id])
		# @book = Book.find(params[:book_id])
		# @article = @author.articles.build
	end

	def create
		if params.has_key?(:author_id)
			@author = Author.find(params[:author_id])
			@article = @author.articles.create(article_params)
		elsif params.has_key?(:book_id)
			@book = Book.find(params[:book_id])
			@article = @book.articles.create(article_params)
		end



	 	# # @author = Author.find(params[:author_id])
	 	# # @book = Book.find(params[:book_id])

	 	# if @author

 		# elsif @book
 		# 	@article = @book.articles.create(article_params)
	 	# end

	 	if @article.save
	 		flash[:success] = "Artikeln '#{@article.title}' är tillagd!"
	 		redirect_to :back
		else
			# Saves error in session variable beacuse I can't render 'new'
			# See: https://railsforum.com/topic/403-im-stumped-displaying-error-messages/
			flash[:danger] = "Artikel kunde inte sparas."
			session[:errors] = @article.errors.full_messages
			redirect_to :back
		end
	end

	# def edit
	# 	@article = Article.find(params[:id])
	# 	# @author = Author.find(params[:author_id])
	# 	# @article = @author.articles.find(params[:id])
	# end

	# def update




	# 	@article = Article.find(params[:id])
	# 	if @article.update_attributes(article_params)
	# 		flash[:success] = "Artikeln är uppdaterad!"
	# 		redirect_to :back
	# 	else
	# 		render 'edit'
	# 	end
	# 	# @author = Author.find(params[:author_id])
	# 	# @book = Book.find(params[:book_id])
	# 	# @article = @author.articles.find(params[:id])
	# 	# if @article.update_attributes(article_params)
	# 	# 	flash[:success] = "Artikeln är uppdaterad!"
	# 	# 	redirect_to :back
	# 	# else
	# 	# 	render 'edit'
	# 	# end
	# end


	# def edit
	# 	@author = Author.find(params[:id])
	# end

	# def update
	# 	@author = Author.find(params[:id])
	# 	if @author.update_attributes(author_params)
	# 		flash[:success] = "Författaren är uppdaterad!"
	# 		redirect_to @author
	# 	else
	# 		render 'edit'
	# 	end
	# end

	def destroy
		Article.find(params[:id]).destroy
		flash[:success] = "Artikel raderad"
		redirect_to :back

		# @author = Author.find(params[:author_id])
		# @article = @author.articles.find(params[:id]).destroy
		# flash[:success] = "Artikeln är raderad!"
	end

	private
		def article_params
			params.require(:article).permit(:title, :writer, :source, :year, :about, :url, :book_id, :author_id)
		end
end