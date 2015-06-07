class Authorship < ActiveRecord::Base
	belongs_to :book
	belongs_to :author
	# validates :author_id, presence: { scope: :book_id }
	# validates :book_id, presence: { scope: :author_id }
	accepts_nested_attributes_for :author
end