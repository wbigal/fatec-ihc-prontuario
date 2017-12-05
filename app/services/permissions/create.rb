module Permissions
  class AlreadyExistsError < StandardError; end
  class SelfPermissionNotAllowed < StandardError; end
  class Create
    attr_reader :patient, :doctor, :deadline

    def initialize(patient:, doctor:, deadline:)
      @patient = patient
      @doctor = doctor
      @deadline = deadline
    end

    def call
      check_self_permission!
      exists_valid_permission!
      Permissao.create(
        medico: doctor,
        pessoa: patient,
        data_limite: deadline,
        data_autorizacao: Time.zone.now
      )
    end

    private

    def exists_valid_permission!
      return if deadline.blank?
      return if Permissao.actived.where(pessoa: patient, medico: doctor).none?
      raise AlreadyExistsError,
            'Você já concedeu permissão ao médico neste período.'
    end

    def check_self_permission!
      return if patient.blank? || doctor.blank?
      return if patient.id != doctor.pessoa.id
      raise SelfPermissionNotAllowed,
            'Você não pode conceder permissão a si próprio.'
    end
  end
end
