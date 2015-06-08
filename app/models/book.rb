class Book < ActiveRecord::Base

  # Make searchable
  searchkick

  validates_associated :authorships

  # Relationships
  belongs_to :genre

  # Cocoon setup
  has_many :authorships, :class_name => 'Authorship', :dependent => :destroy
  has_many :authors, :through => :authorships
  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :authorships, :allow_destroy => true, :reject_if => :all_blank
  has_many :articles, dependent: :destroy
  accepts_nested_attributes_for :articles, :reject_if => :all_blank, :allow_destroy => true

  # Uploaders
  mount_uploader :cover, PictureUploader
  mount_uploader :pdf, PdfUploader
  mount_uploader :epub, EpubUploader

  # Validation
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: { scope: :yearofpub, case_sensitive: false }
  validates :yearofpub, presence: true, length: { maximum: 4 },
    numericality: { only_integer: true, greater_than: 0, less_than: 2050 }
  validates :genre_id, presence: true
  validates :about, length: { maximum: 1000 }
  validates :authorships, presence: { message: " Välj minst en författare." }

  # Custom validator for file size.
  validate :picture_size
  validate :pdf_size
  validate :epub_size

  private

  # Uploaded files maximum size.
  def picture_size
    if cover.size > 2.megabytes
      errors.add(:cover, "får inte vara större än 2MB.")
    end
  end

  def pdf_size
    if pdf.size > 15.megabytes
      errors.add(:pdf, "får inte vara större än 15 Mb")
    end
  end

  def epub_size
    if epub.size > 5.megabytes
      errors.add(:epub, "måste vara mindre än 5 Mb.")
    end
  end
end
