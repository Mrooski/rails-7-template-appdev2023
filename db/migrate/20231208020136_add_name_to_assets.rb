class AddNameToAssets < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :name, :string
  end
end
