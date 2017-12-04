module Doctors
  class MedicalRecordsController < Doctors::BaseController
    before_action :load_permission!, except: %i[index]

    def index
      @permissoes = current_pessoa.medico.permissoes.
                    includes(:pessoa).
                    joins(:pessoa).
                    actived
    end

    def patient_records; end

    private

    def permissao
      @permissao ||= Permissao.actived.find_by(
        id: params[:permissao_id],
        medico: current_pessoa.medico
      )
    end

    def load_permission!
      return if permissao.present?
      flash[:error] = 'Você não possui permissão para acessar o prontuário.'
      redirect_to action: :index
    end
  end
end
