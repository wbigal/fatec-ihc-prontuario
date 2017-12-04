module Permissions
  class AlreadyExistsError < StandardError; end
  class Create
    attr_reader :patient, :doctor, :deadline

    def initialize(patient:, doctor:, deadline:)
      @patient = patient
      @doctor = doctor
      @deadline = deadline
    end

    def call
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
  end
end
