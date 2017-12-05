class SecureMessage
  class InvalidToken < StandardError; end
  class << self
    def encrypt(message)
      message_encryptor.encrypt_and_sign(add_token(message))
    end

    def decrypt(message)
      remove_token(message_encryptor.decrypt_and_verify(message))
    end

    private

    def message_encryptor
      key = ActiveSupport::KeyGenerator.new(
        ENV['SECRET_KEY_BASE']
      ).generate_key(ENV['SALT'], 32)

      ActiveSupport::MessageEncryptor.new(key)
    end

    def add_token(message)
      "#{15.minutes.from_now}|#{message}"
    end

    def remove_token(message)
      parts = message.split('|')
      raise InvalidToken, 'O token é inválido.' if parts.shift.to_datetime.past?
      parts.join('|')
    end
  end
end
