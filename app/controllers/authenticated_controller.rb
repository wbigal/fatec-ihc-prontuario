class AuthenticatedController < ApplicationController
  before_action :authenticate_pessoa!

  protected

  def authenticate_pessoa!
    redirect_to new_accounts_sessions_path unless pessoa_signed_in?
  end
end
