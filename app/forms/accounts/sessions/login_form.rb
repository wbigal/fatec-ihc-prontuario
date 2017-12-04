module Accounts
  module Sessions
    class LoginForm < FormBase
      attr_accessor :email, :password

      validates :email, presence: true, email: true
      validates :password, presence: true
    end
  end
end
