require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

	def setup
		@book = books(:book1)
		@author = authors(:author1)
		@article = Article.new(title: "Artikel om författare", writer: "Pelle Skribent", source: "Dagens Nyheter",
			year: "2014-05-20", about: "Lorem ipsum", url: "www.dn.se", book_id: @book.id, author_id: @author.id)
	end

	# TEST 1.6.1
	test "article should be valid" do
		assert @article.valid?
	end

	# TEST 1.6.2
	test "book_id can be blank if author_id is present" do
		@article.book_id = nil
		assert @article.valid?
	end

	# TEST 1.6.3
	test "author_id can be blank if author_id is present" do
		@article.author_id = nil
		assert @article.valid?
	end

	# Test 1.6.4
	test "book_id or author_id should be present" do
		@article.author_id = nil
		@article.book_id = nil
		assert_not @article.valid?
	end
end