class AddByToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :by, :integer
  end
end
