module Doctors
  module MyAppointments
    class SearchForm < FormBase
      attr_accessor :patient_name, :query_text
      attr_writer :initial_date, :final_date

      validates :initial_date, presence: true
      validates :final_date, presence: true
      validate :dates_rage

      def initial_date
        Time.zone.parse(@initial_date) if @initial_date.present?
      end

      def final_date
        Time.zone.parse(@final_date) if @final_date.present?
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
