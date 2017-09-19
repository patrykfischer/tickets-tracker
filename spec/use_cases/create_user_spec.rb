require 'rails_helper'

RSpec.describe CreateUser do
  context 'Create user' do
    context 'when provided params are not valid' do
      let(:invalid_params) do
        {
          email: 'ben@ben.com',
        }
      end

      it 'should fail with params_not_valid' do
        expect(described_class.run(invalid_params)).to fail_with(:params_not_valid)
      end
    end

    context 'when provided email is not_available' do
      let!(:user) do
        User.create!(
          email: 'ben@ben.com',
          name: 'Test',
        )
      end

      let(:valid_params) do
        {
          email: 'ben@ben.com',
          name: 'Name Test',
        }
      end

      it 'should fail with email_not_available' do
        expect(described_class.run(valid_params)).to fail_with(:email_not_available)
      end
    end

    context 'when provided params are valid' do
      let(:valid_params) do
        {
          email: 'ben@ben.com',
          name: 'Name',
        }
      end

      it 'finishes successfully' do
        result = described_class.run(valid_params)
        expect(result).to be_a_success
      end
    end
  end
end
