class Book < ActiveRecord::Base
  belongs_to :genre

  # Adding pic uploader to book model.
  mount_uploader :cover, PictureUploader
  mount_uploader :pdf, PdfUploader
  mount_uploader :epub, EpubUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :yearofpub, presence: true, length: { maximum: 4 }
  validates :genre_id, presence: true
  # Validera också: yearofpub inte minus.

  #Custom validator for pic size.
  validate :picture_size
  validate :pdf_size
  validate :epub_size

  private
  	# Makes sure cover img is not larger than 5MB.
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
