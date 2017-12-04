module Permissions
  class Revoke
    attr_reader :patient, :permission_id

    def initialize(patient:, permission_id:)
      @patient = patient
      @permission_id = permission_id
    end

    def call
      permissao = patient.permissoes.find(permission_id)
      permissao.revogado = true
      permissao.save
    end
  end
end
