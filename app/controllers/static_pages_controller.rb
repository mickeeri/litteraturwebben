class StaticPagesController < ApplicationController
  def home
  	@books = Book.last(6)
  end

  def help
  end

  def about
  end

  def contact
  end
end
