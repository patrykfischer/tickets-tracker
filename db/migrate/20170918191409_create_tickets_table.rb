class CreateTicketsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string    :name
      t.text      :description
      t.string    :status
      t.float     :estimate
      t.integer   :owner_id
      t.integer   :assigned_to_id
      t.timestamps
    end
  end
end
