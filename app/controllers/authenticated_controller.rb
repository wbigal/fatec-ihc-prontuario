class AuthenticatedController < ApplicationController
  before_action :authenticate_pessoa!

  protected

  def authenticate_pessoa!
    unless pessoa_signed_in?
      flash[:alert] = 'Você precisa se logar para acessar a página solicitada'
      redirect_to new_accounts_sessions_path
    end
  end
end
