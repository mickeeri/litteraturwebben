class ArticlesController < ApplicationController
	def destroy
		@book = Book.find(params[:id])
		@article = @book.articles.find(params[:id])
		@article.destroy
		flash[:success] = "Artikel raderad"
		redirect_to @book
	end
end