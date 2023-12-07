class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.float :price_in_usd

      t.timestamps
    end
  end
end
