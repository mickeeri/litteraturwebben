require 'test_helper'

class BookTest < ActiveSupport::TestCase

	def setup
		@author = Author.new(name: "Astrid Lindgren", about: "Lorem ipsum")
		@author2 = Author.new(name: "Karin Boye", about: "Lorem ipsum")
		@book = Book.new(title: "Testbok", yearofpub: 1879,
									author_ids: [@author.id, @author2.id], about: "Lorem ipsum", genre_id: 1)
	end

	# Test 1.2.1.
	test "book should be valid" do
		assert @book.valid?
	end

	# Test 1.2.2.
	test "title should be present" do
		@book.title = ""
		assert_not @book.valid?
	end

	# Test 1.2.3.
	test "title should be at most 50 characters" do
		@book.title = "a" * 51
		assert_not @book.valid?
	end

	# Test 1.1.4.
	test "yearofpub should not be below zero" do
		@book.yearofpub = -9999
	end
end
