class BooksController < ApplicationController
    before_action :admin_user, only: [:edit, :update, :destroy]


    def index
        @books = Book.all
    end

    def latest
        @books = Book.last(10)
    end

    def show
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
        @book.authorships.build
    end

    def create
        @book = Book.new(book_params)
        # params[:authors][:id].each do |author|
        #     # @book.authors. do |author|
        #     if !author.empty?
        #         @book.authorships.build(:author_id => author)
        #     end
        # end
        if @book.save
            flash[:success] = "Boken '#{@book.title}' är tillagd!"
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
        redirect_to books_url
    end

    # http://stackoverflow.com/questions/17436264/how-to-use-rails-4-strong-parameters-with-has-many-through-association
    # http://stackoverflow.com/questions/21983131/rails-4-nested-attributes-and-has-many-through-associaton-in-a-form
    # http://stackoverflow.com/questions/18308714/nested-fields-and-strong-parameters

    private
    def book_params
        params.require(:book).permit(:title, :yearofpub, :about, :genre_id, :cover, :pdf, :epub, :author_ids => [])
    end

    # Before filters
    def admin_user
        redirect_to(books_url) unless logged_in? && current_user.admin?
    end
end
