class AuthorsController < ApplicationController
	before_action :admin_user, only: [:create, :edit, :update, :destroy]

	def search
		if params[:search].present?
			@authors = Author.search(params[:search])
		else
			@authors = Author.order('lower(name)').paginate(page: params[:page], per_page: 5)
		end
	end

	def index
		@authors = Author.order('lower(name)').paginate(page: params[:page], per_page: 5)
	end

	def latest
		@authors = Author.last(2)
	end

	def show
		@author = Author.find(params[:id])
		@new_article = @author.articles.build
	end

	def new
		@author = Author.new
		# @author.articles.build
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			flash[:success] = "Författaren '#{@author.name}' är tillagd!"
			redirect_to authors_path
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
			params.require(:author).permit(:name, :about, :portrait,
				articles_attributes: [:id, :title, :writer, :year, :source, :about, :url, :_destroy])
		end

		# Before filters
		def admin_user
			redirect_to(authors_url) unless logged_in? && current_user.admin?
		end
end
