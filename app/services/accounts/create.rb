module Accounts
  class RecordInvalid < StandardError; end
  class Create
    attr_reader :cns, :email, :password

    def initialize(cns:, email:, password:)
      @cns = cns
      @email = email
      @password = password
    end

    def call
      pessoa = GetWithoutAccount.new(cns: cns).call
      pessoa.email = email
      pessoa.senha = password
      pessoa.save!
      true
    rescue ActiveRecord::RecordInvalid => e
      raise RecordInvalid, e.message
    end
  end
end
