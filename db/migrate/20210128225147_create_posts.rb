class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :restaurant_name, null: false
      t.string :food_genre, null: false
      t.text :note

      t.timestamps
    end
  end
end
