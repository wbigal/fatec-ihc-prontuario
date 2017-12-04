require 'rails_helper'

RSpec.describe Permissions::Create, type: :service do
  let(:medico) { create(:medico) }
  let(:pessoa) { create(:pessoa) }
  let(:deadline) { 1.hour.from_now }

  subject do
    Permissions::Create.new(
      patient: pessoa,
      doctor: medico,
      deadline: deadline
    )
  end

  context 'when medico has not permissao yet' do
    it { expect(subject.call).to be_an_instance_of(Permissao) }
    it { expect { subject.call }.to change(Permissao, :count).from(0).to(1) }
  end

  context 'when deadline is blank' do
    let(:deadline) { nil }
    it { expect(subject.call).to be_an_instance_of(Permissao) }
    it { expect(subject.call.errors).not_to be_blank }
    it { expect { subject.call }.not_to change(Permissao, :count) }
  end

  context 'when medico has permissao' do
    before { create(:permissao, pessoa: pessoa, medico: medico) }

    it do
      # rubocop:disable Style/RescueModifier
      expect { subject.call rescue nil }.not_to change(Permissao, :count)
    end

    it do
      expect { subject.call }.to raise_error(Permissions::AlreadyExistsError)
    end
  end
end
