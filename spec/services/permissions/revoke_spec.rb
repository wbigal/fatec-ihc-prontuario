require 'rails_helper'

RSpec.describe Permissions::Revoke, type: :service do
  let!(:permissao) { create(:permissao) }
  let(:pessoa) { permissao.pessoa }

  subject do
    Permissions::Revoke.new(patient: pessoa, permission_id: permissao.id)
  end

  before { create(:permissao) }

  it { expect(subject.call).to be_truthy }

  it do
    subject.call
    permissao.reload
    expect(permissao.revogado).to be_truthy
  end
end
