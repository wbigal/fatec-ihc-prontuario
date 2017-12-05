require 'rails_helper'

RSpec.describe Patients::MyMedicalRecords::SearchForm, type: :form do
  it { is_expected.to be_kind_of(FormBase) }

  describe '#initial_date' do
    it { is_expected.to validate_presence_of(:initial_date) }
  end

  describe 'final_date' do
    it { is_expected.to validate_presence_of(:final_date) }

    context 'when the final date is less than the initial date' do
      subject do
        Patients::MyMedicalRecords::SearchForm.new(
          initial_date: Time.zone.now.to_s,
          final_date: 1.day.ago.to_s
        )
      end

      it { expect(subject.valid?).to be_falsy }
    end

    context 'when the final date is bigger than the initial date' do
      subject do
        Patients::MyMedicalRecords::SearchForm.new(
          initial_date: 1.day.ago.to_s,
          final_date: Time.zone.now.to_s
        )
      end

      it { expect(subject.valid?).to be_truthy }
    end

    context 'when the final date is equal than the initial date' do
      subject do
        time = Time.zone.now
        Patients::MyMedicalRecords::SearchForm.new(
          initial_date: time.to_s,
          final_date: time.to_s
        )
      end

      it { expect(subject.valid?).to be_truthy }
    end
  end

  describe '#doctor_name' do
    it { is_expected.to respond_to(:doctor_name) }
  end
end
