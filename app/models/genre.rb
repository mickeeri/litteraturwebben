class Genre < ActiveRecord::Base
	has_many :books
	# accept_nested_attributes_for :books
end
