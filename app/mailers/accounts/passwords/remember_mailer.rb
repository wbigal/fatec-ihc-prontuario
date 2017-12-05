module Accounts
  module Passwords
    class RememberMailer < ApplicationMailer
      def instructions(pessoa:, remember_link:)
        @pessoa = pessoa
        @remember_link = remember_link
        mail(to: pessoa.email,
             subject: '[SPE] Instruções para criar uma nova senha')
      end
    end
  end
end
