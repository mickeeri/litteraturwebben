require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

	def setup
		@author = Author.new(name: "Nisse Författarsson", about: "Lorem ipsum")
	end

	# TEST 1.3.1
	test "author should be valid" do
		assert @author.valid?
	end

	# TEST 1.3.2
	test "name should be present" do
		@author.name = ""
		assert_not @author.valid?
	end

	# TEST 1.3.3
	test "name should be at most 50 charachters" do
		@author.name = "a" * 50
		assert_not @author.valid?
	end

	# TEST 1.3.4
	test "about should be at most 500 charachters" do
		@author.about = "a" * 500
		assert_not @author.valid?
	end
end
