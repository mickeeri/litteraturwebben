require 'test_helper'

class AuthorshipTest < ActiveSupport::TestCase
  def setup
    @authorship = Authorship.new(book_id: 1, author_id: 2)
  end

  test '1.4.1 should be valid' do
    assert @authorship.valid?
  end
end
