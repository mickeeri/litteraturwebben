class Authorship < ActiveRecord::Base
	belongs_to :book
	belongs_to :author
	# validates :author_id, presence: { scope: :book_id }
	# validates :book_id, presence: { scope: :author_id }
	# validates_associated :author
	accepts_nested_attributes_for :author

	private
	# def author_id_unique
	# 	if self.class.exists?(:author_id => author_id)
	# 		errors.add :authorships, "Författare flera gånger."
	# 	end
	# end
end