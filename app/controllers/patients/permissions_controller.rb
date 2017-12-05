module Patients
  class PermissionsController < AuthenticatedController
    rescue_from 'Permissions::AlreadyExistsError', with: :error_handler
    rescue_from 'Permissions::SelfPermissionNotAllowed', with: :error_handler

    def index
      @permissoes = current_pessoa.permissoes.
                    includes(medico: :pessoa).
                    joins(medico: :pessoa).
                    actived
    end

    def search_doctor; end

    def new
      @medico = Medico.joins(:pessoa).find_by!(crm: params[:crm])
      @permissao = Permissao.new(medico: @medico)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "O CRM #{params[:crm]} não esta cadastrado no SPE"
      redirect_to action: :search_doctor
    end

    def create
      @medico = Medico.find(permissao_params[:medico_id])
      @permissao = create_permissao

      if @permissao.persisted?
        flash[:success] = 'O médico recebeu a autorização com sucesso'
        redirect_to action: :index
      else
        render :new
      end
    end

    def destroy
      Permissions::Revoke.new(
        patient: current_pessoa,
        permission_id: params[:id].try(:to_i)
      ).call

      flash[:success] = 'Autorização revogada com sucesso'
      redirect_to action: :index
    end

    private

    def create_permissao
      Permissions::Create.new(
        patient: current_pessoa,
        doctor: @medico,
        deadline: permissao_params[:data_limite]
      ).call
    end

    def permissao_params
      params.require(:permissao).permit(:data_limite, :medico_id)
    end

    def error_handler(exception)
      flash[:error] = exception.message
      redirect_to action: :search_doctor
    end
  end
end
