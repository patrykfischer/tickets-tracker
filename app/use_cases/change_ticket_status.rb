class ChangeTicketStatus
  include SolidUseCase

  steps :fetch_ticket,
        :change_status,
        :send_message

  def initialize(notification_service: Notification)
    @notification_service = notification_service
  end

  def fetch_ticket(params)
    params[:ticket] = Ticket.find_by!(id: params[:ticket_id])
    continue params
  rescue ActiveRecord::RecordNotFound
    fail :ticket_not_found, error: 'TICKET_NOT_FOUND'
  end

  def change_status(params)
    if can_transition?(params[:ticket], params[:status])
      params[:ticket].update_attributes(status: params[:status])
      continue params[:ticket]
    else
      fail :cannot_transition, error: 'CANNOT_TRANSITION'
    end
  end

  def send_message(ticket)
    notification_service.perform_later(ticket.owner.email)
    continue ticket
  end

  private

  attr_accessor :notification_service

  def can_transition?(ticket, status)
    status.to_sym.in? ticket.available_statuses
  end
end
