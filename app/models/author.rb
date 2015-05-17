class Author < ActiveRecord::Base
	# Misc
	searchkick
	mount_uploader :portrait, PortraitUploader

	# Relationships
    has_many :authorships, foreign_key: :author_id, dependent: :destroy
    has_many :books, through: :authorships, source: :book
    has_many :articles, dependent: :destroy
    accepts_nested_attributes_for :articles, :reject_if => :all_blank, :allow_destroy => true

    # Validation
    validate :portrait_size

    private

    	# Validates portrait picture size.
	    def portrait_size
	    	if portrait.size > 5.megabytes
	    		erros.add(:portrait, "får inte vara större än 5MB")
	    	end
	    end
end
