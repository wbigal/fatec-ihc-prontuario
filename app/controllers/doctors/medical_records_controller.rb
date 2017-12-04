module Doctors
  class MedicalRecordsController < Doctors::BaseController
    before_action :load_permission!, except: %i[index]
    rescue_from 'MedicalRecords::AttendanceNotAllowed',
                with: :attendance_not_allowed_handler

    def index
      @permissoes = current_pessoa.medico.permissoes.
                    includes(:pessoa).
                    joins(:pessoa).
                    actived
    end

    def patient_records
      @atendimentos = @permissao.pessoa.atendimentos.
                      joins(medico: :pessoa).
                      order(data_atendimento: :desc)
    end

    def new
      @atendimento = Atendimento.new
    end

    def create
      @atendimento = create_medical_records

      if @atendimento.persisted?
        flash[:success] = 'Atendimento registrado com sucesso'
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def load_permission!
      return if permissao.present?
      flash[:error] = 'Você não possui permissão para acessar o prontuário.'
      redirect_to action: :index
    end

    def attendance_not_allowed_handler(exception)
      flash[:error] = exception.message
      redirect_to action: :index
    end

    def permissao
      @permissao ||= Permissao.actived.find_by(
        id: params[:permissao_id],
        medico: current_pessoa.medico
      )
    end

    def create_medical_records
      MedicalRecords::Create.new(
        permission: @permissao,
        doctor: current_pessoa.medico,
        record: atendimento_params
      ).call
    end

    def atendimento_params
      params.require(:atendimento).permit(
        :sintomas,
        :diagnosticos,
        :prescricao_medicamentos,
        :prescricao_procedimentos
      )
    end
  end
end
