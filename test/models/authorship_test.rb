require 'test_helper'

class AuthorshipTest < ActiveSupport::TestCase
	def setup
		@authorship = Authorship.new(book_id: 1, author_id: 2)
	end

	# TEST 1.4.1
	test "should be valid" do
		assert @authorship.valid?
	end

	# test "should require a book_id" do
	# 	@authorship.book_id = nil
	# 	assert_not @authorship.valid?
	# end

	# test "should require author_id" do
	# 	@authorship.author_id = nil
	# 	assert_not @authorship.valid?
	# end
end
