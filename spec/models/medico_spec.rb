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

require 'rails_helper'

RSpec.describe Medico, type: :model do
  it 'has a valid factory' do
    expect(create(:medico)).to be_valid
  end

  describe '#atendimentos' do
    it { is_expected.to have_many(:atendimentos) }
  end

  describe '#permissoes' do
    it { is_expected.to have_many(:permissoes) }
  end

  describe '#pessoa' do
    it { is_expected.to belong_to(:pessoa) }
    it { is_expected.to validate_presence_of(:pessoa).with_message(:required) }
  end

  describe '#crm' do
    it { is_expected.to validate_presence_of(:crm) }
    it do
      is_expected.to validate_numericality_of(:crm).
        only_integer.
        is_greater_than(0)
    end
  end
end
