class TicketForm < Reform::Form
   properties :name,
              :description,
              :status,
              :estimate,
              validates:  { presence: true }

   properties :owner_id, :assigned_to_id
end
