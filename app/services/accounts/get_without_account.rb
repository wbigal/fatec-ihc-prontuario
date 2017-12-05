module Accounts
  class AlreadyExistsError < StandardError; end
  class PessoaNotFound < StandardError; end
  class GetWithoutAccount
    attr_reader :cns

    def initialize(cns:)
      @cns = cns
    end

    def call
      verify!
      pessoa
    end

    private

    def pessoa
      @pessoa ||= Pessoa.find_by!(cns: cns)
    rescue ActiveRecord::RecordNotFound
      raise PessoaNotFound, "O CNS #{cns} não esta cadastrado no SPE."
    end

    def verify!
      return unless pessoa.account?
      raise AlreadyExistsError, "O CNS #{cns} já possui uma conta no SPE"
    end
  end
end
