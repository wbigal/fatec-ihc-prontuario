module Accounts
  class PasswordsController < ApplicationController
    before_action :load_pessoa, except: %i[index remember]

    rescue_from 'Accounts::AccountNotFound', with: :account_error_handler
    rescue_from 'ActiveSupport::MessageVerifier::InvalidSignature',
                with: :invalid_token_handler

    def index
      @remember = Accounts::Passwords::RememberForm.new
    end

    def remember
      @remember = Accounts::Passwords::RememberForm.new(password_params)

      if @remember.valid? && send_instructions
        flash[:notice] = 'Um e-mail será enviado a você com as instruções para'\
                         ' registrar uma nova senha.'
        redirect_to new_accounts_sessions_path
      else
        render :index
      end
    end

    def edit
      @create_password = Accounts::Passwords::CreateForm.new
    end

    def update
      @create_password = Accounts::Passwords::CreateForm.new(
        create_password_params
      )

      @pessoa.senha = @create_password.password

      if @pessoa.save
        flash[:success] = 'Sua senha foi altrada com sucesso!'
        redirect_to new_accounts_sessions_path
      else
        render :edit
      end
    end

    private

    def send_instructions
      Accounts::SendInstructions.new(email: password_params[:email]).call
    end

    def account_error_handler(exception)
      flash[:error] = exception
      redirect_to action: :index
    end

    def invalid_token_handler
      flash[:error] = 'Seu solicitação de alteração não é válida.'
      redirect_to action: :index
    end

    def load_pessoa
      @pessoa = Pessoa.find(SecureMessage.decrypt(params[:id]))
    end

    def password_params
      params.require(:accounts_passwords_remember_form).permit(:email)
    end

    def create_password_params
      params.require(:accounts_passwords_create_form).permit(
        :password,
        :password_confirmation
      )
    end
  end
end
