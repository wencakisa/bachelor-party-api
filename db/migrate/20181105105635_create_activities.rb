class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :subtitle
      t.string :details
      t.boolean :transfer_included
      t.boolean :guide_included
      t.integer :duration

      t.timestamps
    end
  end
end
