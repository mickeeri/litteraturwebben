class Authorship < ActiveRecord::Base
	belongs_to :book
	belongs_to :author
	# validates :author_id, presence: true
	# validates :book_id, presence: true
end
