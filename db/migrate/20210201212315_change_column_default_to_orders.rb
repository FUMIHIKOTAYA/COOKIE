class ChangeColumnDefaultToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :recommend_dish, from: nil, to: ""
  end
end
