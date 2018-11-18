class AddUniqueIndexActivitiesQuotations < ActiveRecord::Migration[5.2]
  def change
    add_index :activities_quotations, [:quotation_id, :activity_id], unique: true
    add_index :activities_quotations, :activity_id
  end
end
