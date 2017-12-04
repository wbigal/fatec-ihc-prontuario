module Permissions
  class Refuse
    attr_reader :doctor, :permission_id

    def initialize(doctor:, permission_id:)
      @doctor = doctor
      @permission_id = permission_id
    end

    def call
      permissao = doctor.permissoes.find(permission_id)
      permissao.nao_aceito = true
      permissao.save
    end
  end
end
