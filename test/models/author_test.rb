require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

	def setup
		@author = Author.new(name: "Nisse Författarsson", about: "Lorem ipsum")
	end

	test "Test 1.3.1: author should be valid" do
		assert @author.valid?
	end

	test "Test 1.3.2: name should be present" do
		@author.name = ""
		assert_not @author.valid?
	end

	test "Test 1.3.3: name should be at most 50 charachters" do
		@author.name = "a" * 51
		assert_not @author.valid?
	end

	test "Test 1.3.4: about should be at most 1000 charachters" do
		@author.about = "a" * 1004
		assert_not @author.valid?
	end
end
