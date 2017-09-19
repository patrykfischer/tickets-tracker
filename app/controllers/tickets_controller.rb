class TicketsController < ApplicationController
  def create
    CreateTicket.run(params_with_user).match do
      success do |ticket|
        render json: ticket
      end

      failure do |error|
        render json: error, status: 422
      end
    end
  end

  def index
    render json: Ticket.all
  end

  def change_status
    ChangeTicketStatus.run(params_with_user).match do
      success do |ticket|
        render json: ticket
      end

      failure do |error|
        render json: error
      end
    end
  end

  private

  def params_with_user
    params.merge(user: user)
  end
end
