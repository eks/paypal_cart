class CreateUserInfo < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :country
      t.string :state
      t.string :zipcode
      t.string :street
      t.references :user
    end
  end
end
