class ArticlesController < ApplicationController

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
		@author = Author.find(params[:author_id])
		@book = Auhor.dinf(params[:book_id])

		@articles = @author.articles

	end

	def show
		@author = Author.find(params[:author_id])
		@article = @author.articles.build
	end

	def new
		@author = Author.find(params[:author_id])
		@artile = @author.articles.build
	end

	def edit
		@author = Author.find(params[:author_id])
		@article = @author.articles.find(params[:id])
	end

	def create
	 	@author = Author.find(params[:author_id])

	 	if @author
	 		@article = @author.articles.create(article_params)
 		elsif @book
 			@article = @book.articles.create(article_params)
	 	end

	 	if @article.save
	 		flash[:success] = "Artikeln '#{@article.title}' är tillagd!"
	 		redirect_to :back
		else
			render 'new'
		end
	end

	def update
		@author = Author.find(params[:author_id])
		@book = Book.find(params[:book_id])
		@article = @author.articles.find(params[:id])
		if @article.update_attributes(article_params)
			flash[:success] = "Artikeln är uppdaterad!"
			redirect_to :back
		else
			render 'edit'
		end
	end

	def destroy
		@author = Author.find(params[:author_id])
		@article = @author.articles.find(params[:id]).destroy
		flash[:success] = "Artikeln är raderad!"
	end

	private
		def article_params
			params.require(:article).permit(:title, :writer, :source, :year, :about, :url, :book_id, :author_id)
		end
end