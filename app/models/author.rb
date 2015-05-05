class Author < ActiveRecord::Base
    has_many :authorships, foreign_key: :author_id, dependent: :destroy
    has_many :books, through: :authorships, source: :book
end
