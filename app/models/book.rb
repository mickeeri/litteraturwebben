class Book < ActiveRecord::Base
  belongs_to :genre

  # Adding pic uploader to book model.
  mount_uploader :cover, PictureUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :yearofpub, presence: true, length: { maximum: 4 }
  validates :genre_id, presence: true
  # Validera också: yearofpub inte minus.

  #Custom validator for pic size.
  validate :picture_size

  private
  	# Makes sure cover img is not larger than 5MB.
  	def picture_size
  		if cover.size > 5.megabytes
  			errors.add(:picture, "måste vara mindre än 5MB.")
  		end
  	end
end
