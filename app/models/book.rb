class Book < ActiveRecord::Base

    # Make searchable
    searchkick

    validates_associated :authorships

    # Relationships
    belongs_to :genre
    #has_many :authorships, foreign_key: :book_id, dependent: :destroy
    #has_many :authors, through: :authorships, source: :author

    # Cocoon setup
    has_many :authorships, :class_name => 'Authorship', :dependent => :destroy
    has_many :authors, :through => :authorships
    accepts_nested_attributes_for :authors

    accepts_nested_attributes_for :authorships, :allow_destroy => true, :reject_if => :all_blank

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
    validates :title, presence: { message: "Titel måste anges."}, length: { maximum: 100, message: "Titel får inte överstiga 100 tecken." }
    validates :yearofpub, presence: { message: "Utgivningsår måste anges."}, length: { maximum: 4, message: "Utgivningsår: max 4 siffror" },
      numericality: { only_integer: true, greater_than: 0, less_than: 2050, message: "Utgivningsår ska vara en siffra mellan 0 och 2050" }
    validates :genre_id, presence: { message: "Genre saknas"}
    validates :about, length: { maximum: 1000, message: "Beskrivning av bok får inte överstiga 1000 tecken." }
    validates :authorships, presence: { message: " Välj minst en författare"}

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

        # def no_author(attributes)
        #     attributes[:id].blank?
        # end
end
