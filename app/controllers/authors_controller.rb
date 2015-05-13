class AuthorsController < ApplicationController
	before_action :admin_user, only: [:create, :edit, :update, :destroy]

	def index
		@authors = Author.search(params[:search])
	end

	def show
		@author = Author.find(params[:id])
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

	private
		def author_params
			params.require(:author).permit(:name, :about,
				articles_attributes: [:id, :title, :writer, :year, :source, :about, :url, :_destroy])
		end

		# Before filters
		def admin_user
			redirect_to(authors_url) unless logged_in? && current_user.admin?
		end

end
