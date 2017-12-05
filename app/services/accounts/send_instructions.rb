module Accounts
  class AccountNotFound < StandardError; end
  class SendInstructions
    attr_reader :email

    def initialize(email:)
      @email = email
    end

    def call
      Accounts::Passwords::RememberMailer.instructions(
        pessoa: pessoa,
        remember_link: remember_link
      ).deliver_now
      true
    end

    private

    def pessoa
      @pessoa ||= Pessoa.find_by!(email: email)
    rescue ActiveRecord::RecordNotFound
      raise AccountNotFound, 'O e-mail informado não esta cadastrado no SPE.'
    end

    def remember_link
      Rails.application.routes.url_helpers.send(
        'edit_accounts_password_url',
        id: SecureMessage.encrypt(pessoa.id)
      )
    end
  end
end
