module Doctors
  class MedicalRecordsController < Doctors::BaseController
    def index
      @permissoes = current_pessoa.medico.permissoes.
                    includes(:pessoa).
                    joins(:pessoa).
                    actived
    end
  end
end
