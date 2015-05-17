# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# !create method raises exception for invalid user rather than returning false.
User.create!(name: "admin",
			email: "admin@mail.com",
			password: "lösenord",
			password_confirmation: "lösenord",
			admin: true)

Author.create!(name: "August Strindberg",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Selma Lagerlöf",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Hjalmar Söderberg",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Viktor Rydberg",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Carl Jonas Love Almqvist",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Erik Lindegren",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

Author.create!(name: "Victoria Benedictsson",
	about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Maecenas mollis vestibulum elementum. Curabitur et pretium lorem.
	Nulla malesuada, purus quis sodales hendrerit, turpis lacus imperdiet arcu,
	quis venenatis dui mauris at enim. Praesent at ligula a felis iaculis gravida nec at lectus.
	Nullam nec tellus malesuada, feugiat nisl sed, elementum lectus.
	Integer venenatis, erat in condimentum cursus, lectus augue vulputate tellus,
	et dictum elit risus a quam. Aliquam erat volutpat. Proin vel eros in mauris ornare ornare in id turpis.")

# Using Faker gem to make 99 example users.
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@mail.com"
	password = "password"
	User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password)
end

Genre.create(genre: "Skönlitteratur")
Genre.create(genre: "Lyrik")
Genre.create(genre: "Dramatik")
Genre.create(genre: "Faktalitteratur")
Genre.create(genre: "Essäer")
