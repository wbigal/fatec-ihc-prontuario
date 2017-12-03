class AuthenticatedController < ApplicationController
  before_action :authenticate_pessoa!

  protected

  def authenticate_pessoa!
    redirect_to new_accounts_session_path unless pessoa_signed_in?
  end
end
