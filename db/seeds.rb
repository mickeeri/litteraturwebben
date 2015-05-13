# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# !create method raises exception for invalid user rather than returning false.
# User.create!(name: "admin",
# 			email: "admin@mail.com",
# 			password: "lösenord",
# 			password_confirmation: "lösenord",
# 			admin: true)

# # Using Faker gem to make 99 example users.
# 99.times do |n|
# 	name = Faker::Name.name
# 	email = "example-#{n+1}@mail.com"
# 	password = "password"
# 	User.create!(name: name,
# 				email: email,
# 				password: password,
# 				password_confirmation: password)
# end

fiction = Genre.create(genre: "Skönlitteratur")
poetry = Genre.create(genre: "Lyrik")
drama = Genre.create(genre: "Dramatik")
facts = Genre.create(genre: "Faktalitteratur")
essays = Genre.create(genre: "Essäer")
