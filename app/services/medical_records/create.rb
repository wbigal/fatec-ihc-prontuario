module MedicalRecords
  class AttendanceNotAllowed < StandardError; end
  class Create
    attr_reader :permission, :patient, :doctor, :record

    def initialize(permission:, doctor:, record:)
      @permission = permission
      @patient = permission.pessoa
      @doctor = doctor
      @record = record
    end

    def call
      exists_valid_permission!

      permission.create_atendimento(
        medico: doctor,
        pessoa: patient,
        data_atendimento: Time.zone.now,
        sintomas: record[:sintomas],
        diagnosticos: record[:diagnosticos],
        prescricao_medicamentos: record[:prescricao_medicamentos],
        prescricao_procedimentos: record[:prescricao_procedimentos]
      )
    end

    private

    def exists_valid_permission!
      return if Permissao.actived.where(
        id: permission.id,
        pessoa: patient,
        medico: doctor
      ).any?

      raise AttendanceNotAllowed,
            'Você não permissão para acessar o prontuário'
    end
  end
end
