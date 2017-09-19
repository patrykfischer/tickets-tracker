require 'rails_helper'

RSpec.describe CreateTicket do
  let!(:user) do
    User.create!(
      email: 'lootbank@loot.io',
      name: 'Name',
    )
  end

  context 'Create ticket' do
    context 'when provided params are not valid' do
      let(:invalid_params) do
        {
          user: user,
        }
      end

      it 'should fail with params_not_valid' do
        expect(described_class.run(invalid_params)).to fail_with(:params_not_valid)
      end
    end

    context 'when provided params are valid' do
      let(:valid_params) do
        {
          user: user,
          status: 'open',
          name: 'Name',
          description: 'description',
          estimate: 1,
        }
      end

      it 'finishes successfully' do
        result = described_class.run(valid_params)
        expect(result).to be_a_success
        expect(result.value.owner.id).to be_equal user.id
      end
    end
  end
end
