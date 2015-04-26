class Book < ActiveRecord::Base
  belongs_to :genre

  # Adding pic uploader to book model.
  mount_uploader :cover, PictureUploader
  mount_uploader :pdf, PdfUploader
  validates :title, presence: true, length: { maximum: 50 }
  validates :yearofpub, presence: true, length: { maximum: 4 }
  validates :genre_id, presence: true
  # Validera också: yearofpub inte minus.

  #Custom validator for pic size.
  validate :picture_size
  validate :pdf_size

  # def download_url
  #   s3 = AWS::S3.new.buckets['railsproject-bucket']

  #   s3.objects[self.path].url_for(:read,
  #     expires_in: 60.minutes,
  #     use_ssl: true,
  #     response_content_disposition: "attachment; filename='#{attachment_file_name}'").to_s
  # end

  # def download_url
  #   credentials = Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY'])
  #   s3 = Aws::S3::Resource.new(
  #     credentials: credentials,
  #     region: 'eu-central-1'
  #   )
  #   object = s3.bucket('railsproject-bucket').object(self.cover.path)
  #   return object.public_url
  # end


  def pdf_url
    if Rails.env.production?
      credentials = Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY'])
      s3 = Aws::S3::Resource.new(
        credentials: credentials,
        region: 'eu-central-1'
      )
      object = s3.bucket('railsproject-bucket').object(self.cover.path)
      return object.public_url
    else
      return self.pdf.path
    end
  end


      #   :provider => 'AWS',
      # :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      # :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      # :region                => 'eu-central-1'

  private
  	# Makes sure cover img is not larger than 5MB.
  	def picture_size
  		if cover.size > 5.megabytes
  			errors.add(:picture, "måste vara mindre än 5MB.")
  		end
  	end

    def pdf_size
      if pdf.size > 20.megabytes
        erros.add(:pdf, "är för stor.")
      end
    end
end
