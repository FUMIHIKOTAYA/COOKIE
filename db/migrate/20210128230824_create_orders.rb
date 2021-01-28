class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :recommend_dish, null: false
      t.text :reason
      t.string :dish_image

      t.timestamps
    end
  end
end
