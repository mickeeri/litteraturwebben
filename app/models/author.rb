class Author < ActiveRecord::Base
    has_many :authorships, foreign_key: :author_id, dependent: :destroy
    has_many :books, through: :authorships, source: :book
    has_many :articles, dependent: :destroy
    accepts_nested_attributes_for :articles, :reject_if => :all_blank, :allow_destroy => true


    def self.search(search)
		if search
			all.where(:conditions => ['title LIKE ?', "%#{search}%"])
		else
			all
		end
    end
end
