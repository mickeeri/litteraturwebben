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

  # def pdf_url
  #   if Rails.env.production?
  #     credentials = Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY'])
  #     s3 = Aws::S3::Resource.new(
  #       credentials: credentials,
  #       region: 'eu-central-1'
  #     )
  #     object = s3.bucket('railsproject-bucket').object(self.pdf.path)
  #     return object.url_for(:read, expires_in: 60.minutes)
  #   else
  #     return self.pdf.path
  #   end
  # end

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
