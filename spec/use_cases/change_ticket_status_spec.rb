require 'rails_helper'

RSpec.describe ChangeTicketStatus do
  let(:user) do
    User.create!(
      email: 'lootbank@loot.io',
      name: 'Name',
    )
  end

  let!(:ticket) do
    Ticket.create!(
      name: 'Name',
      description: 'description',
      status: 'open',
      estimate: 1,
      owner_id: user.id,
    )
  end

  context 'Change ticket status' do
    context 'when ticket not exist' do
      let(:invalid_params) do
        {
          user: user,
          status: 'closed',
          ticket_id: 'not_exist_id',
        }
      end

      it 'should fail with ticket_not_found' do
        expect(described_class.run(invalid_params)).to fail_with(:ticket_not_found)
      end
    end

    context 'when ticket exist' do
      context 'and cannot make transition' do
        let(:invalid_params) do
          {
            user: user,
            status: 'closed',
            ticket_id: ticket.id,
          }
        end

        it 'should fail with cannot_transition' do
          expect(described_class.run(invalid_params)).to fail_with(:cannot_transition)
        end
      end

      context 'and params are valid' do
        let(:valid_params) do
          {
            user: user,
            status: 'in_progress',
            ticket_id: ticket.id,
          }
        end

        it 'finishes successfully' do
          expect(described_class.run(valid_params)).to be_a_success
        end
      end
    end
  end
end
