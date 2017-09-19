class CreateTicket
  include SolidUseCase

  steps :validate,
        :create,
        :send_message

  def initialize(notification_service = Notification,
                 ticket_form = TicketForm)
    @notification_service = notification_service
    @ticket_form = ticket_form
  end

  def validate(params)
    form = ticket_form.new(Ticket.new)
    if form.validate params
      params[:ticket] = form.sync
      continue params
    else
      fail :params_not_valid, error: 'PARAMS_NOT_VALID'
    end
  end

  def create(params)
    params[:ticket].owner = params[:user]
    params[:ticket].save
    continue params[:ticket]
  end

  def send_message(ticket)
    notification_service.perform_later(ticket.owner.email)
    continue ticket
  end

  private

  attr_accessor :notification_service,
                :ticket_form
end
