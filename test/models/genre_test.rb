require 'test_helper'

class GenreTest < ActiveSupport::TestCase
    def setup
        @genre = Genre.new(genre: "Skönlitteratur")
    end

    test "1.5.1 genre should be valid" do
        @genre.valid?
    end
end
