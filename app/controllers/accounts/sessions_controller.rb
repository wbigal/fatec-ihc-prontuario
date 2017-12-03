module Accounts
  class SessionsController < ApplicationController
    def new
      @pessoa = Pessoa.new
    end

    def create
      email = pessoa_params[:email]
      senha = pessoa_params[:senha]
      pessoa = People::Login.new(email: email, password: senha).call

      if pessoa.present?
        self.current_pessoa = pessoa
        redirect_to '/'
      else
        flash[:error] = 'E-mail ou senha inválidos'
        redirect_to action: :new
      end
    end

    private

    def pessoa_params
      params.require(:pessoa).permit(:email, :senha)
    end
  end
end
