class CreateJoinTableActivitiesPrices < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :prices do |t|
      t.index [:activity_id, :price_id]
      # t.index [:price_id, :activity_id]
    end
  end
end
