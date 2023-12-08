class CreateTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :trades do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :asset_id
      t.string :asset_quantity

      t.timestamps
    end
  end
end
