require 'rails_helper'

RSpec.describe MedicalRecords::Create, type: :service do
  let(:permissao) { create(:permissao) }
  let(:medico) { permissao.medico }

  let(:record) do
    Hash[
      sintomas: 'sintomas',
      diagnosticos: 'diagnosticos',
      prescricao_medicamentos: 'prescricao_medicamentos',
      prescricao_procedimentos: 'prescricao_procedimentos'
    ]
  end

  subject do
    MedicalRecords::Create.new(
      permission: permissao,
      doctor: medico,
      record: record
    )
  end

  before { create(:permissao) }

  context 'when medico has not permissao yet' do
    let(:permissao) { create(:permissao, revogado: true) }
    it do
      expect { subject.call }.to raise_error(
        MedicalRecords::AttendanceNotAllowed
      )
    end
  end

  context 'when medico has permissao' do
    it { expect(subject.call).to be_an_instance_of(Atendimento) }
    it { expect { subject.call }.to change(Atendimento, :count).from(0).to(1) }
  end
end
