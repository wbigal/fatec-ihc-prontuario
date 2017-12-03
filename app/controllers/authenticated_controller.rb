class AuthenticatedController < ApplicationController
  before_action :authenticate_pessoa!

  protected

  def authenticate_pessoa!
    return if pessoa_signed_in?
    flash[:alert] = 'Você precisa se logar para acessar o sistema'
    redirect_to new_accounts_sessions_path
  end
end
