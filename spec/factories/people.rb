FactoryBot.define do
  factory :person do
    cns {Faker::Number.number(10)}
    birth_date {Faker::Date.birthday(18, 65)}
    email {Faker::Internet.email}
    password {Faker::Internet.password} 
  end
end
