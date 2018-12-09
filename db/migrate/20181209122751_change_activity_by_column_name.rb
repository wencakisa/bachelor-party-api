class ChangeActivityByColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :by, :time_type
  end
end
