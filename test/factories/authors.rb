# t.string   "name"
# t.text     "about"
# t.string   "portrait"
# t.integer  "yearofbirth"

FactoryGirl.define do
  factory :author do
    name { Faker::Book.author }
    about Faker::Lorem.sentence(100)
    yearofbirth Faker::Number.between(1700, 2000)
  end
end
