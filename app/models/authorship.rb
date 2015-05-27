class Authorship < ActiveRecord::Base
	belongs_to :book
	belongs_to :author
	validates :author_id, presence: { message: "Objektet saknar koppling till författare" }
	# validates :book_id, presence: true
	# validates_associated :author
	accepts_nested_attributes_for :author

	private
	# def author_id_unique
	# 	if self.class.exists?(:author_id => author_id)
	# 		errors.add :authorships, "Författare flera gånger."
	# 	end
	# end
end