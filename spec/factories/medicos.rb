# == Schema Information
#
# Table name: medicos
#
#  id         :integer          not null, primary key
#  pessoa_id  :integer          not null
#  crm        :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :medico do
    pessoa
    crm { Faker::Number.number(6) }
  end
end
