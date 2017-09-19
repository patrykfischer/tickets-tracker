class CreateUser
  include SolidUseCase

  steps :validate,
        :check_email_uniq,
        :create,
        :send_welcome_message

  def initialize(notification_service = Notification)
    @notification_service = notification_service
  end

  def validate(params)
    form = UserForm.new(User.new)
    if form.validate(params)
      params[:user] = form.sync
      continue params
    else
      fail :params_not_valid, error: 'PARAMS_NOT_VALID'
    end
  end

  def check_email_uniq(params)
    return continue params unless User.find_by(email: params[:user].email).present?
    fail :email_not_available, error: 'EMAIL_NOT_AVAILABLE'
  end

  def create(params)
    params[:user].save
    continue params[:user]
  end

  def send_welcome_message(user)
    notification_service.perform_later(user.email)
    continue user
  end

  private

  attr_accessor :notification_service
end
