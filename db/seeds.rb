Genre.create(genre: "Skönlitteratur")
Genre.create(genre: "Lyrik")
Genre.create(genre: "Dramatik")
Genre.create(genre: "Faktalitteratur")
Genre.create(genre: "Essäer")

# Users
99.times { FactoryGirl.create :user }

# Admin user
User.create(name: "Mikael Eriksson",
            email: "admin@test.com",
            password: "password",
            password_confirmation: "password",
            admin: true)

# Authors
10.times do
  FactoryGirl.create :author
end

Author.create!(
  name: "August Strindberg",
  yearofbirth: 1787,
  about: Faker::Lorem.sentence(30)
)

Author.create!(name: "Selma Lagerlöf",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(30))

Author.create!(name: "Hjalmar Söderberg",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(30))

Author.create!(name: "Viktor Rydberg",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(30))

Author.create!(name: "Carl Jonas Love Almqvist",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(30))

Author.create!(name: "Erik Lindegren",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(50))

Author.create!(name: "Victoria Benedictsson",
               yearofbirth: 1787,
               about: Faker::Lorem.sentence(30))

# Books
Author.all.each do |author|
  genre = Genre.offset(rand(Genre.count)).first
  book = FactoryGirl.build :book, genre: genre

  author.books << book
end
