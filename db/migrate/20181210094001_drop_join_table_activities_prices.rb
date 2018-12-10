class DropJoinTableActivitiesPrices < ActiveRecord::Migration[5.2]
  def change
    drop_join_table :activities, :prices
  end
end
