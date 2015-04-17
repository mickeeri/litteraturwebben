require 'test_helper'

class BookTest < ActiveSupport::TestCase

	def setup
		@genre = genres(:genre_one)
		@book = @genre.books.build(title: "Röda rummet", yearofpub: 1879,
									about: "En roman av Strindberg.")
	end

	test "book should be valid" do
		assert @book.valid?
	end

	test "title should be present" do
		@book.title = nil
		assert_not @book.valid?
	end

	test "title should be at most 50 characters" do
		@book.title = "a" * 51
		assert_not @book.valid?
	end
end
