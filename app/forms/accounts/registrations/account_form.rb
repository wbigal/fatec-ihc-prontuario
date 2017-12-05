module Accounts
  module Registrations
    class AccountForm < FormBase
      attr_accessor :cns, :email, :password, :password_confirmation

      validates :cns, presence: true, length: { is: 16 }

      validates :email, presence: true,
                        email: true,
                        length: { maximum: 100 }

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
