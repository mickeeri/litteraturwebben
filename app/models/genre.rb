class Genre < ActiveRecord::Base
	has_many :authors
end
