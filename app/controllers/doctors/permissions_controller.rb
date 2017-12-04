module Doctors
  class PermissionsController < Doctors::BaseController
    def destroy
      Permissions::Refuse.new(
        doctor: current_pessoa.medico,
        permission_id: params[:id].try(:to_i)
      ).call

      flash[:success] = 'Autorização recusada com sucesso'
      redirect_to doctors_medical_records_path
    end
  end
end
