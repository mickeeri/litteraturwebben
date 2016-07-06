class Author < ActiveRecord::Base
  # Misc
  searchkick
  mount_uploader :portrait, PortraitUploader

  # Relationships
  has_many :authorships, class_name: 'Authorship', dependent: :destroy
  has_many :books, through: :authorships
  has_many :articles, dependent: :destroy
  accepts_nested_attributes_for :articles,
                                reject_if: :all_blank,
                                allow_destroy: true

  # Validation
  # Authors can have same name but combination of
  # name and yearofbirth must be unique.
  validates :name,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { scope: :yearofbirth, case_sensitive: false }
  validates :about, length: { maximum: 1000 }
  validates :yearofbirth,
            presence: true,
            length: { maximum: 4 },
            numericality: { greater_than: 0, less_than: 2050 }
  validate :portrait_size

  private

  # Validation for picture file size.
  def portrait_size
    if portrait.size > 3.megabytes
      errors.add(:portrait, 'får inte vara större än 3 Mb')
    end
  end
end
