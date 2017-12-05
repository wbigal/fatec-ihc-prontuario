require 'rails_helper'

RSpec.describe SecureMessage, type: :lib do
  let(:message) { 'Hello World|;!' }

  describe '.encrypt' do
    it { expect(SecureMessage.encrypt(message)).not_to eq(message) }
    it { expect(SecureMessage.encrypt(message)).not_to be_blank }
  end

  describe '.decrypt' do
    context 'when the token is valid' do
      let(:encripted_message) { SecureMessage.encrypt(message) }
      it { expect(SecureMessage.decrypt(encripted_message)).to eq(message) }
    end

    context 'when the token is invalid' do
      let!(:time_now) { Time.zone.now }
      let!(:time_past) { 16.minutes.ago }

      let(:encripted_message) do
        Timecop.travel(time_past)
        result = SecureMessage.encrypt(message)
        Timecop.travel(time_now)
        result
      end

      after { Timecop.return }

      it do
        expect do
          SecureMessage.decrypt(encripted_message)
        end.to raise_error(SecureMessage::InvalidToken)
      end
    end
  end
end
