class User < ActiveRecord::Base
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: :assigned_to_id
  has_many :own_tickets, class_name: 'Ticket', foreign_key: :owner_id
end
