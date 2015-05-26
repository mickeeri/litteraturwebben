class Book < ActiveRecord::Base

    # Make searchable
    searchkick

    # Relationships
    belongs_to :genre
    #has_many :authorships, foreign_key: :book_id, dependent: :destroy
    #has_many :authors, through: :authorships, source: :author

    # Cocoon setup
    has_many :authorships, :class_name => 'Authorship'
    has_many :authors, :through => :authorships, :class_name => 'Author'
    accepts_nested_attributes_for :authors
    accepts_nested_attributes_for :authorships, :allow_destroy => true

    has_many :articles, dependent: :destroy
    #accepts_nested_attributes_for :authors
    #accepts_nested_attributes_for :authorships
    # accepts_nested_attributes_for :authorships, reject_if: :all_blank, allow_destroy: true
    accepts_nested_attributes_for :articles, :reject_if => :all_blank, :allow_destroy => true
    # http://stackoverflow.com/questions/27459269/rails-4-collection-select-multiple-nested-attributes-not-saving-properly

    # Uploaders
    mount_uploader :cover, PictureUploader
    mount_uploader :pdf, PdfUploader
    mount_uploader :epub, EpubUploader

    # Validation
    validates :title, presence: true, length: { maximum: 50 }
    validates :yearofpub, presence: true, length: { maximum: 4 },
      numericality: { only_integer: true, greater_than: 0, less_than: 2050 }
    validates :genre_id, presence: true
    validates :about, length: { maximum: 500 }

    # Custom validator for file size.
    validate :picture_size
    validate :pdf_size
    validate :epub_size

    private

        # Uploaded files maximum size.
        def picture_size
            if cover.size > 5.megabytes
                errors.add(:picture, "måste vara mindre än 5MB.")
            end
        end

        def pdf_size
            if pdf.size > 20.megabytes
                errors.add(:pdf, "får inte vara större än 20MB")
            end
        end

        def epub_size
            if epub.size > 10.megabytes
                errors.add(:epub, "måste vara mindre än 10MB.")
            end
        end
end
