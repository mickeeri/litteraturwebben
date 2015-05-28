require 'test_helper'

class BookTest < ActiveSupport::TestCase

	def setup
		@author1 = authors(:author1)
		@author2 = authors(:author2)
		@book = Book.new(title: "Testbok", yearofpub: 1879, about: "Lorem ipsum", genre_id: 1,
			cover: "testbok.png", pdf: "testbok.pdf", epub: "testbok.epub")
		@authorship1 = Authorship.new(book_id: @book.id, author_id: @author1.id)
		@authorship2 = Authorship.new(book_id: @book.id, author_id: @author2.id)
	end

	test "1.2.1 - book should be valid" do
		assert @authorship1.valid?
		assert @authorship2.valid?
		# Adding authors to book.
		@book.authorships.push(@authorship1)
		@book.authorships.push(@authorship2)
		# Verifying book.
		assert @book.valid?
	end

	test "1.2.2 - title should be present" do
		@book.title = ""
		assert_not @book.valid?
	end

	test "1.2.3 - title should be at most 100 characters" do
		@book.title = "a" * 101
		assert_not @book.valid?
	end

	test "1.1.4 - yearofpub should not be below zero" do
		@book.yearofpub = -9999
	end

	# test "1.2.5 - book cant have two authorships with same id." do
	# 	# Adding authors to book.
	# 	@book.authorships.push(@authorship1)
	# 	@book.authorships.push(@authorship1)
	# 	# Verifying book.
	# 	assert_not @book.valid?
	# end
end
