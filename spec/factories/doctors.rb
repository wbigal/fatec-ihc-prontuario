FactoryBot.define do
  factory :doctor do
    person nil
    crm {Faker::Number.number(10)}
  end
end
