class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :status, default: 0
      t.timestamps
    end
    add_monetize :orders, :price, currency: { present: false }
  end
end
