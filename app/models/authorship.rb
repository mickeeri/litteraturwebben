class Authorship < ActiveRecord::Base
	belongs_to :book
	belongs_to :author
	#validates :author_id, presence: true
	#validates :book_id, presence: true
	accepts_nested_attributes_for :author, :reject_if => :all_blank
end
