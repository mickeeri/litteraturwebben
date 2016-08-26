# t.string   "title"
# t.integer  "yearofpub"
# t.text     "about"
# t.integer  "genre_id"
# t.string   "cover"
# t.string   "pdf"
# t.string   "epub"

FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    yearofpub { Faker::Number.between(1700, 2000) }
    about Faker::Lorem.sentence(100)
    genre nil
  end
end
