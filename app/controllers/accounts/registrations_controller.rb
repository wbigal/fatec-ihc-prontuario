module Accounts
  class RegistrationsController < ApplicationController
    rescue_from 'Accounts::PessoaNotFound', with: :account_error_handler
    rescue_from 'Accounts::AlreadyExistsError', with: :account_error_handler

    def index
      @registration = Accounts::Registrations::SearchCnsForm.new
    end

    def new
      @registration = Accounts::Registrations::SearchCnsForm.new(
        registration_params
      )

      if @registration.valid?
        @pessoa = Accounts::GetWithoutAccount.new(cns: @registration.cns).call
        @account = Accounts::Registrations::AccountForm.new(registration_params)
      else
        render :index
      end
    end

    def create
      @account = Accounts::Registrations::AccountForm.new(account_params)

      if @account.valid? && create_account
        flash[:success] = 'Sua conta foi criada com sucesso e '\
                          'já pode ser utilizada'
        redirect_to new_accounts_sessions_path
      else
        render :new
      end
    end

    private

    def create_account
      Accounts::Create.new(
        cns: account_params[:cns],
        email: account_params[:email],
        password: account_params[:password]
      ).call
    rescue Accounts::RecordInvalid => e
      flash[:error] = e
      false
    end

    def account_error_handler(exception)
      flash[:error] = exception
      redirect_to action: :index
    end

    def registration_params
      params.require(:accounts_registrations_search_cns_form).permit(:cns)
    end

    def account_params
      params.require(:accounts_registrations_account_form).permit(
        :cns,
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end
