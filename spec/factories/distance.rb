FactoryBot.define do
  factory :distance do
    point_a  { Faker::Lorem.word }
    point_b  { Faker::Lorem.word }
    distance { Faker::Number.between(1, 100000) }
  end
end
