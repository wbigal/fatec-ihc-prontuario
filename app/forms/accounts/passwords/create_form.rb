module Accounts
  module Passwords
    class CreateForm < FormBase
      attr_accessor :password, :password_confirmation

      validates :password, presence: true,
                           length: { minimum: 6, maximum: 10 }

      validates :password_confirmation, presence: true,
                                        length: { minimum: 6, maximum: 10 }

      validate :confirm_password

      private

      def confirm_password
        return if password.blank? || password_confirmation.blank?
        return if password == password_confirmation
        errors.add(
          :password_confirmation,
          'A senha confirmada não esta correta'
        )
      end
    end
  end
end
