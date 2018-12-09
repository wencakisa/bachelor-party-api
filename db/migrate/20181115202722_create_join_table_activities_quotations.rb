class CreateJoinTableActivitiesQuotations < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activities, :quotations do |t|
      t.index [:activity_id, :quotation_id]
      # t.index [:quotation_id, :activity_id]
    end
  end
end
