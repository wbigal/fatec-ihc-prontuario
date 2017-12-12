require 'rails_helper'

RSpec.describe Doctors::MyAppointments::SearchForm, type: :form do
  it { is_expected.to be_kind_of(FormBase) }

  describe '#initial_date' do
    it { is_expected.to validate_presence_of(:initial_date) }
  end

  describe 'final_date' do
    it { is_expected.to validate_presence_of(:final_date) }

    context 'when the final date is less than the initial date' do
      subject do
        Doctors::MyAppointments::SearchForm.new(
          initial_date: Time.zone.now.to_s,
          final_date: 1.day.ago.to_s
        )
      end

      it { expect(subject.valid?).to be_falsy }
    end

    context 'when the final date is bigger than the initial date' do
      subject do
        Doctors::MyAppointments::SearchForm.new(
          initial_date: 1.day.ago.to_s,
          final_date: Time.zone.now.to_s
        )
      end

      it { expect(subject.valid?).to be_truthy }
    end

    context 'when the final date is equal than the initial date' do
      subject do
        time = Time.zone.now.to_s
        Doctors::MyAppointments::SearchForm.new(
          initial_date: time,
          final_date: time
        )
      end

      it { expect(subject.valid?).to be_truthy }
    end
  end

  describe '#patient_name' do
    it { is_expected.to respond_to(:patient_name) }
  end

  describe '#query_text' do
    it { is_expected.to respond_to(:query_text) }
  end
end
