class Article < ActiveRecord::Base
  belongs_to :book
  belongs_to :author

  # Basic validation of article year/date.
  VALID_YEAR_REGEX = /[0-9-]/i

  # Validation
  validates :title, presence: true, length: { maximum: 50 }
  validates :year, presence: true,
    format: { with: VALID_YEAR_REGEX, message: "i formatet (åååå) eller (åååå-mm-dd)."}, length: { maximum: 10 }
  validates :writer, presence: true, length: { maximum: 50 }
  validates :source, presence: true, length: { maximum: 30 }
  validates :about, length: { maximum: 350 }
  validates :url, length: { maximum: 100 }

  # book_id must be present unless author_id is present and vice-versa.
  # http://guides.rubyonrails.org/active_record_validations.html#using-a-proc-with-if-and-unless
  validates :book_id, presence: true, :unless => Proc.new { |a| a.author_id? }
  validates :author_id, presence: true, :unless => Proc.new { |a| a.book_id? }
end