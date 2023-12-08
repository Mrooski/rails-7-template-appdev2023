class AddTickerToAssets < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :ticker, :string
  end
end
