class ChangeTypeStringToIntPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :food_genre, 'integer USING CAST(food_genre AS integer)'
  end
end
