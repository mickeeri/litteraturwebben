class Author < ActiveRecord::Base
	# Misc
	searchkick
	mount_uploader :portrait, PortraitUploader

	# Relationships
    # has_many :authorships, foreign_key: :author_id, dependent: :destroy
    # has_many :books, through: :authorships, source: :book
    has_many :authorships, :class_name => 'Authorship', :dependent => :destroy
    has_many :books, through: :authorships
    has_many :articles, dependent: :destroy
    accepts_nested_attributes_for :articles, :reject_if => :all_blank, :allow_destroy => true

    # Validation
    validates :name, presence: { message: "Författarens namn får inte vara tomt" },
        length: { maximum: 50, message: "Författarens namn får inte överstiga 50 tecken." }
    validates :about, length: { maximum: 1000, message: "Beskrivningen får inte överstiga 1000 tecken." }
    validate :portrait_size

    private
    	# Validates portrait picture size.
	    def portrait_size
	    	if portrait.size > 5.megabytes
	    		erros.add("Filen får inte vara större än 5MB")
	    	end
	    end
end
