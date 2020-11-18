class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.string :carrier, null: false
      t.string :tracking_reference, null: false
      t.string :tracking_status, null: false, default: 'created'
      t.string :notification_status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
