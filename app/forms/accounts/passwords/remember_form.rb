module Accounts
  module Passwords
    class RememberForm < FormBase
      attr_accessor :email

      validates :email, presence: true, email: true
    end
  end
end
