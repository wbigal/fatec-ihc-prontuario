module Doctors
  class BaseController < AuthenticatedController
    protected

    def authenticate_pessoa!
      super
      return if pessoa.medico.present?
      flash[:alert] = 'Você não pode acessar a página solicitada'
      redirect_to root_path, status: :unauthorized
    end
  end
end
