class Ticket < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, required: false
  belongs_to :assigned_to, class_name: 'User', foreign_key: :assigned_to_id, required: false

  state_machine :status, initial: :open do
    event :start do
      transition open: :in_progress
    end

    event :done do
      transition in_progress: :done
    end

    event :start_testing do
      transition done: :testing
    end

    event :accept do
      transition testing: :closed
    end

    event :reject do
      transition testing: :open
    end
  end

  def available_statuses
    self.status_transitions.map(&:to_name)
  end
end
