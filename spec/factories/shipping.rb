FactoryBot.define do
  factory :shipping do
    origin      { Faker::Lorem.word }
    destination { Faker::Lorem.word }
    weight      { Faker::Number.between(1, 50) }
  end
end
