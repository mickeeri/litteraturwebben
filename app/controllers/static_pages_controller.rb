class StaticPagesController < ApplicationController
  def home
  	@books = Book.last(8)
  	@authors = Author.last(4)
  end

  def help
  end

  def about
  end

  def contact
  end
end
