module Doctors
  module MyAppointments
    class SearchForm < FormBase
      attr_accessor :patient_name
      attr_writer :initial_date, :final_date

      validates :initial_date, presence: true
      validates :final_date, presence: true
      validate :dates_rage

      def initial_date
        @initial_date&.to_datetime
      end

      def final_date
        @final_date&.to_datetime
      end

      private

      def dates_rage
        return if initial_date.blank? || final_date.blank?
        return if initial_date <= final_date
        errors.add(:final_date, 'deve ser posterior ou igual a Data Inicial')
      end
    end
  end
end
