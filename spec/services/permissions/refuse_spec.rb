require 'rails_helper'

RSpec.describe Permissions::Refuse, type: :service do
  let!(:permissao) { create(:permissao) }
  let(:medico) { permissao.medico }

  subject do
    Permissions::Refuse.new(doctor: medico, permission_id: permissao.id)
  end

  before { create(:permissao) }

  it { expect(subject.call).to be_truthy }

  it do
    subject.call
    permissao.reload
    expect(permissao.nao_aceito).to be_truthy
  end
end
