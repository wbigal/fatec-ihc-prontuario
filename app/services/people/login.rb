module People
  class Login
    attr_reader :email, :password

    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      pessoa = Pessoa.find_by!(email: email)
      pessoa if pessoa.correct_senha?(password)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
