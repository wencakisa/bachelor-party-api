class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.float :amount
      t.string :options

      t.timestamps
    end
  end
end
