class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_pessoa
    @current_pessoa = if session[:current_pessoa].present?
                        Pessoa.includes(:medico).find(session[:current_pessoa])
                      end
  end

  def current_pessoa=(pessoa)
    session[:current_pessoa] = pessoa&.id
  end

  def pessoa_signed_in?
    session[:current_pessoa].present?
  end
end
