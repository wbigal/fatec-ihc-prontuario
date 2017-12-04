module Accounts
  class SessionsController < ApplicationController
    def new
      @login = Accounts::Sessions::LoginForm.new
    end

    def create
      @login = Accounts::Sessions::LoginForm.new(pessoa_params)

      if @login.valid?
        validate_login
      else
        render :new
      end
    end

    def destroy
      sign_out
      redirect_to action: :new
    end

    private

    def validate_login
      pessoa = People::Login.new(email: @login.email,
                                 password: @login.password).call

      if pessoa.present?
        self.current_pessoa = pessoa
        redirect_to '/'
      else
        flash[:error] = 'E-mail ou senha inválidos'
        redirect_to action: :new
      end
    end

    def pessoa_params
      params.require(:accounts_sessions_login_form).permit(:email, :password)
    end
  end
end
