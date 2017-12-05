module Accounts
  module Registrations
    class SearchCnsForm < FormBase
      attr_accessor :cns

      validates :cns, presence: true, length: { is: 16 }
    end
  end
end
