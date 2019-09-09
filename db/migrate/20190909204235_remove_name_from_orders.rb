class RemoveNameFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :name
  end
end
