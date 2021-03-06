# == Schema Information
#
# Table name: pessoas
#
#  id              :integer          not null, primary key
#  cns             :string(16)       not null
#  nome_completo   :string(255)      not null
#  data_nascimento :date             not null
#  email           :string(100)
#  senha           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :pessoa do
    cns { Faker::Number.number(16).to_s }
    nome_completo 'Fabio Carille'
    data_nascimento Date.new(1973, 9, 26)

    trait :with_account do
      email { Faker::Internet.email }
      senha 'ABC123'
    end
  end
end
