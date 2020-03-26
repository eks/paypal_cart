class AddTokenToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :token, :string
    add_column :orders, :charge_id, :string
    add_column :orders, :error_message, :string
    add_column :orders, :customer_id, :string
  end
end
