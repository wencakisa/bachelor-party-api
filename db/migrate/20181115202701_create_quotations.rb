class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.integer :status, default: 0
      t.integer :group_size
      t.string :user_email

      t.timestamps
    end
  end
end
